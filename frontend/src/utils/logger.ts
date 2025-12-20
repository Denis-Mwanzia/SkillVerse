/**
 * Centralized logging utility
 * Provides consistent logging across the application with environment-aware behavior
 */

type LogLevel = 'debug' | 'info' | 'warn' | 'error';

interface LogEntry {
  level: LogLevel;
  message: string;
  data?: unknown;
  timestamp: string;
}

class Logger {
  private isDev = import.meta.env.DEV;
  private isTest = import.meta.env.MODE === 'test';

  private formatMessage(level: LogLevel, message: string, data?: unknown): LogEntry {
    return {
      level,
      message,
      data,
      timestamp: new Date().toISOString(),
    };
  }

  private log(level: LogLevel, message: string, data?: unknown): void {
    // Don't log in test environment to avoid cluttering test output
    if (this.isTest) return;

    const entry = this.formatMessage(level, message, data);

    // In development, use console methods for better debugging
    if (this.isDev) {
      switch (level) {
        case 'debug':
          console.debug(`[${entry.timestamp}] ${message}`, data || '');
          break;
        case 'info':
          console.info(`[${entry.timestamp}] ${message}`, data || '');
          break;
        case 'warn':
          console.warn(`[${entry.timestamp}] ${message}`, data || '');
          break;
        case 'error':
          console.error(`[${entry.timestamp}] ${message}`, data || '');
          break;
      }
    } else {
      // In production, you might want to send logs to an external service
      // For now, we only log errors in production
      if (level === 'error') {
        // TODO: Integrate with error reporting service (e.g., Sentry, LogRocket)
        console.error(`[${entry.timestamp}] ${message}`, data || '');
      }
    }
  }

  debug(message: string, data?: unknown): void {
    this.log('debug', message, data);
  }

  info(message: string, data?: unknown): void {
    this.log('info', message, data);
  }

  warn(message: string, data?: unknown): void {
    this.log('warn', message, data);
  }

  error(message: string, error?: unknown): void {
    this.log('error', message, error);
  }
}

export const logger = new Logger();

