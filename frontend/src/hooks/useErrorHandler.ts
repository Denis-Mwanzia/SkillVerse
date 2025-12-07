import { useCallback } from 'react';
import { toast } from '@/hooks/use-toast';
import { AxiosError } from 'axios';

interface ErrorHandlerOptions {
  showToast?: boolean;
  fallbackMessage?: string;
}

export function useErrorHandler() {
  const handleError = useCallback((error: unknown, options: ErrorHandlerOptions = {}) => {
    const { showToast = true, fallbackMessage = 'An unexpected error occurred' } = options;

    let message = fallbackMessage;
    let title = 'Error';

    if (error instanceof AxiosError) {
      if (error.response) {
        // Server responded with error status
        const data = error.response.data as any;
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

    // Log error for debugging (development only)
    if (import.meta.env.DEV) {
      console.error('Error handled:', error);
    }

    return { message, title };
  }, []);

  return { handleError };
}

