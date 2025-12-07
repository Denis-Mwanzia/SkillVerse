import axiosInstance from './axiosInstance';
import type { AuthResponse, LoginRequest, User } from '@/types/api';

export const authApi = {
  login: async (credentials: LoginRequest): Promise<AuthResponse> => {
    try {
      const response = await axiosInstance.post<AuthResponse>('/api/auth/login', credentials);
      return response.data;
    } catch (error) {
      // Fallback to mock for development
      if (import.meta.env.DEV) {
        return new Promise((resolve) => {
          setTimeout(() => {
            resolve({
              access_token: 'mock_access_token_' + Date.now(),
              refresh_token: 'mock_refresh_token_' + Date.now(),
              user: {
                id: 'user_1',
                email: credentials.email,
                name: 'Demo User',
                createdAt: new Date().toISOString(),
              },
            });
          }, 500);
        });
      }
      throw error;
    }
  },

  logout: async (): Promise<void> => {
    localStorage.removeItem('access_token');
    localStorage.removeItem('refresh_token');
  },

  getProfile: async (): Promise<User> => {
    try {
      const response = await axiosInstance.get<User>('/api/auth/profile');
      return response.data;
    } catch (error) {
      // Fallback for development
      if (import.meta.env.DEV) {
        const token = localStorage.getItem('access_token');
        if (!token) {
          throw new Error('Not authenticated');
        }
        return {
          id: 'user_1',
          email: 'demo@skillverse.ai',
          name: 'Alex Johnson',
          createdAt: '2024-01-15T00:00:00Z',
        };
      }
      throw error;
    }
  },

  register: async (data: { email: string; password: string; name: string }): Promise<AuthResponse> => {
    const response = await axiosInstance.post<AuthResponse>('/api/auth/register', data);
    return response.data;
  },

  updateProfile: async (data: {
    name?: string;
    email?: string;
    bio?: string;
    location?: string;
    website?: string;
    linkedin?: string;
    github?: string;
  }): Promise<User> => {
    try {
      const response = await axiosInstance.patch<User>('/api/auth/profile', data);
      return response.data;
    } catch (error) {
      // Fallback for development
      if (import.meta.env.DEV) {
        return new Promise((resolve) => {
          setTimeout(() => {
            resolve({
              id: 'user_1',
              email: data.email || 'demo@skillverse.ai',
              name: data.name || 'Demo User',
              createdAt: new Date().toISOString(),
              ...data,
            });
          }, 500);
        });
      }
      throw error;
    }
  },

  updatePassword: async (data: { currentPassword: string; newPassword: string }): Promise<void> => {
    try {
      await axiosInstance.post('/api/auth/change-password', data);
    } catch (error) {
      // Fallback for development
      if (import.meta.env.DEV) {
        return new Promise((resolve) => {
          setTimeout(() => resolve(), 500);
        });
      }
      throw error;
    }
  },

  uploadAvatar: async (file: File): Promise<{ avatarUrl: string }> => {
    try {
      const formData = new FormData();
      formData.append('avatar', file);
      const response = await axiosInstance.post<{ avatarUrl: string }>('/api/auth/avatar', formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });
      return response.data;
    } catch (error) {
      // Fallback for development
      if (import.meta.env.DEV) {
        return new Promise((resolve) => {
          setTimeout(() => {
            resolve({
              avatarUrl: URL.createObjectURL(file),
            });
          }, 1000);
        });
      }
      throw error;
    }
  },
};
