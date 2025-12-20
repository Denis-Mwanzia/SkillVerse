/**
 * Environment variable validation and type-safe access
 */

interface Env {
  VITE_API_URL: string;
  VITE_SOCKET_URL: string;
  VITE_ENV: 'development' | 'production' | 'test';
}

const requiredEnvVars: (keyof Env)[] = ['VITE_API_URL'];

function validateEnv(): void {
  const missing: string[] = [];

  requiredEnvVars.forEach((key) => {
    if (!import.meta.env[key]) {
      missing.push(key);
    }
  });

  if (missing.length > 0) {
    throw new Error(
      `Missing required environment variables: ${missing.join(', ')}\n` +
      `Please check your .env file or environment configuration.`
    );
  }
}

// Validate on import (development only)
if (import.meta.env.DEV) {
  try {
    validateEnv();
  } catch (error) {
    console.warn('Environment validation warning:', error);
  }
}

export const env: Env = {
  VITE_API_URL: import.meta.env.VITE_API_URL || 'http://localhost:8000',
  VITE_SOCKET_URL: import.meta.env.VITE_SOCKET_URL || import.meta.env.VITE_API_URL || 'http://localhost:8000',
  VITE_ENV: (import.meta.env.VITE_ENV || import.meta.env.MODE || 'development') as Env['VITE_ENV'],
};

export const isDev = env.VITE_ENV === 'development';
export const isProd = env.VITE_ENV === 'production';
export const isTest = env.VITE_ENV === 'test';

/**
 * Type-safe environment variable accessor
 * @param key - Environment variable key
 * @param defaultValue - Optional default value if env var is not set
 * @returns The environment variable value or default
 */
export function getEnvVar<K extends keyof Env>(
  key: K,
  defaultValue?: Env[K]
): Env[K] {
  const value = env[key];
  if (value === undefined || value === '') {
    if (defaultValue !== undefined) {
      return defaultValue;
    }
    throw new Error(`Environment variable ${key} is not set and no default value provided`);
  }
  return value;
}

