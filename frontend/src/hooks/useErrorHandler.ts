import { useCallback } from 'react';
import { toast } from '@/hooks/use-toast';
import { AxiosError } from 'axios';
import { logger } from '@/utils/logger';

interface ErrorHandlerOptions {
  showToast?: boolean;
  fallbackMessage?: string;
}

interface ErrorResponse {
  message?: string;
  detail?: string;
}

export function useErrorHandler() {
  const handleError = useCallback((error: unknown, options: ErrorHandlerOptions = {}) => {
    const { showToast = true, fallbackMessage = 'An unexpected error occurred' } = options;

    let message = fallbackMessage;
    let title = 'Error';

    if (error instanceof AxiosError) {
      if (error.response) {
        // Server responded with error status
        const data = error.response.data as ErrorResponse | undefined;
        message = data?.message || data?.detail || error.message || fallbackMessage;
        title = `Error ${error.response.status}`;
      } else if (error.request) {
        // Request made but no response
        message = 'Network error. Please check your connection and try again.';
        title = 'Connection Error';
      } else {
        // Something else happened
        message = error.message || fallbackMessage;
      }
    } else if (error instanceof Error) {
      message = error.message || fallbackMessage;
    }

    if (showToast) {
      toast({
        title,
        description: message,
        variant: 'destructive',
      });
    }

    // Log error using logger utility
    logger.error(`Error handled: ${title}`, error);

    return { message, title };
  }, []);

  return { handleError };
}

