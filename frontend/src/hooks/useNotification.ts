/**
 * Unified notification hook
 * Combines toast notifications (temporary) with persistent notifications (stored)
 */
import { useCallback } from 'react';
import { toast } from '@/hooks/use-toast';
import { useUIStore } from '@/store/uiStore';
import type { Notification } from '@/store/uiStore';

interface NotificationOptions {
  /** Show as toast (temporary) */
  showToast?: boolean;
  /** Store as persistent notification */
  persistent?: boolean;
  /** Toast variant (if showing toast) */
  variant?: 'default' | 'destructive' | 'success' | 'warning' | 'info';
  /** URL to navigate to when notification is clicked */
  actionUrl?: string;
  /** Duration in ms for toast (default: 5000) */
  duration?: number;
}

export function useNotification() {
  const { addNotification } = useUIStore();

  const notify = useCallback(
    (title: string, message: string, type: Notification['type'] = 'info', options: NotificationOptions = {}) => {
      const { showToast = true, persistent = false, variant, actionUrl, duration = 5000 } = options;

      // Show toast notification
      if (showToast) {
        const toastVariant = variant || 
          (type === 'error' ? 'destructive' :
           type === 'success' ? 'success' :
           type === 'warning' ? 'warning' :
           type === 'info' ? 'info' : 'default');

        toast({
          title,
          description: message,
          variant: toastVariant as 'default' | 'destructive' | 'success' | 'warning' | 'info',
        });
      }

      // Store persistent notification
      if (persistent) {
        addNotification({
          type,
          title,
          message,
          timestamp: Date.now(),
          actionUrl,
        });
      }
    },
    [addNotification]
  );

  const notifySuccess = useCallback(
    (title: string, message: string, options?: NotificationOptions) => {
      notify(title, message, 'success', options);
    },
    [notify]
  );

  const notifyError = useCallback(
    (title: string, message: string, options?: NotificationOptions) => {
      notify(title, message, 'error', { variant: 'destructive', ...options });
    },
    [notify]
  );

  const notifyWarning = useCallback(
    (title: string, message: string, options?: NotificationOptions) => {
      notify(title, message, 'warning', options);
    },
    [notify]
  );

  const notifyInfo = useCallback(
    (title: string, message: string, options?: NotificationOptions) => {
      notify(title, message, 'info', options);
    },
    [notify]
  );

  return {
    notify,
    notifySuccess,
    notifyError,
    notifyWarning,
    notifyInfo,
  };
}

