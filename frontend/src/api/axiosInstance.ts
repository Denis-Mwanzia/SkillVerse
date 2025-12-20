import axios, { AxiosInstance, AxiosError, InternalAxiosRequestConfig } from 'axios';
import { env } from '@/utils/env';
import { tokenStorage } from '@/utils/storage';
import { logger } from '@/utils/logger';

const API_BASE_URL = env.VITE_API_URL;

interface QueuedRequest {
  resolve: (token: string) => void;
  reject: (error: Error) => void;
}

let isRefreshing = false;
let failedQueue: QueuedRequest[] = [];

const processQueue = (error: Error | null, token: string | null = null) => {
  failedQueue.forEach((prom) => {
    if (error) {
      prom.reject(error);
    } else {
      prom.resolve(token!);
    }
  });
  failedQueue = [];
};

export const axiosInstance: AxiosInstance = axios.create({
  baseURL: API_BASE_URL,
  timeout: 30000,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Request interceptor
axiosInstance.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    const token = tokenStorage.getAccessToken();
    if (token && config.headers) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => Promise.reject(error)
);

// Response interceptor
axiosInstance.interceptors.response.use(
  (response) => response,
  async (error: AxiosError) => {
    const originalRequest = error.config as InternalAxiosRequestConfig & { _retry?: boolean };

    // Handle 401 Unauthorized - Token refresh
    if (error.response?.status === 401 && !originalRequest._retry) {
      if (isRefreshing) {
        return new Promise<string>((resolve, reject) => {
          failedQueue.push({ resolve, reject });
        })
          .then((token) => {
            if (originalRequest.headers) {
              originalRequest.headers.Authorization = `Bearer ${token}`;
            }
            return axiosInstance(originalRequest);
          })
          .catch((err) => Promise.reject(err));
      }

      originalRequest._retry = true;
      isRefreshing = true;

      const refreshToken = tokenStorage.getRefreshToken();

      if (!refreshToken) {
        tokenStorage.clearTokens();
        window.location.href = '/login';
        return Promise.reject(error);
      }

      try {
        const response = await axios.post<{ access_token: string; refresh_token: string }>(
          `${API_BASE_URL}/api/auth/refresh`,
          {
            refresh_token: refreshToken,
          }
        );

        const { access_token, refresh_token } = response.data;
        tokenStorage.setTokens(access_token, refresh_token);

        processQueue(null, access_token);

        if (originalRequest.headers) {
          originalRequest.headers.Authorization = `Bearer ${access_token}`;
        }

        return axiosInstance(originalRequest);
      } catch (refreshError) {
        processQueue(refreshError as Error, null);
        tokenStorage.clearTokens();
        logger.error('Token refresh failed', refreshError);
        window.location.href = '/login';
        return Promise.reject(refreshError);
      } finally {
        isRefreshing = false;
      }
    }

    // Enhance error messages for better UX
    if (error.response) {
      const status = error.response.status;
      interface ErrorResponse {
        message?: string;
        detail?: string;
      }
      const data = error.response.data as ErrorResponse | undefined;

      // Create user-friendly error messages
      const message =
        data?.message ||
        data?.detail ||
        (status === 403 ? 'You do not have permission to perform this action' :
        status === 404 ? 'The requested resource was not found' :
        status === 429 ? 'Too many requests. Please try again later' :
        status >= 500 ? 'Server error. Please try again later' :
        'An error occurred while processing your request');

      const enhancedError = new Error(message) as AxiosError;

      Object.assign(enhancedError, {
        response: error.response,
        request: error.request,
        config: error.config,
        isAxiosError: true,
      });

      return Promise.reject(enhancedError);
    }

    // Network errors
    if (error.request && !error.response) {
      const networkError = new Error(
        'Network error. Please check your internet connection and try again.'
      ) as AxiosError;
      
      Object.assign(networkError, {
        request: error.request,
        config: error.config,
        isAxiosError: true,
      });

      return Promise.reject(networkError);
    }

    return Promise.reject(error);
  }
);

export default axiosInstance;
