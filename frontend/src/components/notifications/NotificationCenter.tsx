import { useState } from 'react';
import { Bell, X, CheckCheck, Info, AlertCircle, AlertTriangle, CheckCircle } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { useNavigate } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { ScrollArea } from '@/components/ui/scroll-area';
import { Badge } from '@/components/ui/badge';
import { useUIStore } from '@/store/uiStore';
import { formatDistanceToNow } from 'date-fns';
import { cn } from '@/lib/utils';
import { useReducedMotion } from '@/utils/motion';

export function NotificationCenter() {
  const { notifications, removeNotification, markAllAsRead, clearAllNotifications, markAsRead } = useUIStore();
  const [isOpen, setIsOpen] = useState(false);
  const navigate = useNavigate();
  const prefersReducedMotion = useReducedMotion();
  const unreadCount = notifications.filter((n) => !n.read).length;

  const handleNotificationClick = (notif: typeof notifications[0]) => {
    if (!notif.read) {
      markAsRead(notif.id);
    }
    if (notif.actionUrl) {
      navigate(notif.actionUrl);
      setIsOpen(false);
    }
  };

  const getNotificationIcon = (type: 'info' | 'success' | 'warning' | 'error') => {
    switch (type) {
      case 'success':
        return <CheckCircle className="h-5 w-5 text-green-600 dark:text-green-400" />;
      case 'warning':
        return <AlertTriangle className="h-5 w-5 text-yellow-600 dark:text-yellow-400" />;
      case 'error':
        return <AlertCircle className="h-5 w-5 text-red-600 dark:text-red-400" />;
      default:
        return <Info className="h-5 w-5 text-blue-600 dark:text-blue-400" />;
    }
  };

  const getNotificationColor = (type: 'info' | 'success' | 'warning' | 'error') => {
    switch (type) {
      case 'success':
        return 'border-green-200 bg-green-50 dark:border-green-800 dark:bg-green-950/20';
      case 'warning':
        return 'border-yellow-200 bg-yellow-50 dark:border-yellow-800 dark:bg-yellow-950/20';
      case 'error':
        return 'border-red-200 bg-red-50 dark:border-red-800 dark:bg-red-950/20';
      default:
        return 'border-blue-200 bg-blue-50 dark:border-blue-800 dark:bg-blue-950/20';
    }
  };

  const handleClearAll = () => {
    clearAllNotifications();
  };

  const handleMarkAllAsRead = () => {
    markAllAsRead();
  };

  return (
    <div className="relative">
      <Button
        variant="ghost"
        size="icon"
        className="relative"
        onClick={() => setIsOpen(!isOpen)}
        aria-label={`Notifications${unreadCount > 0 ? ` (${unreadCount} unread)` : ''}`}
        aria-expanded={isOpen}
      >
        <Bell className="h-5 w-5" />
        {unreadCount > 0 && (
          <Badge
            variant="destructive"
            className="absolute -top-1 -right-1 h-5 w-5 flex items-center justify-center p-0 text-xs"
          >
            {unreadCount > 9 ? '9+' : unreadCount}
          </Badge>
        )}
      </Button>

      <AnimatePresence>
        {isOpen && (
          <>
            {/* Backdrop */}
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              transition={{ duration: prefersReducedMotion ? 0 : 0.2 }}
              className="fixed inset-0 z-40 bg-black/50"
              onClick={() => setIsOpen(false)}
              aria-hidden="true"
            />

            {/* Notification Panel */}
            <motion.div
              initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0, y: -10, scale: 0.95 }}
              animate={prefersReducedMotion ? {} : { opacity: 1, y: 0, scale: 1 }}
              exit={prefersReducedMotion ? { opacity: 0 } : { opacity: 0, y: -10, scale: 0.95 }}
              transition={{ duration: prefersReducedMotion ? 0 : 0.2 }}
              className="absolute right-0 top-full mt-2 w-96 max-w-[calc(100vw-2rem)] bg-card border border-border rounded-lg shadow-xl z-50"
              role="dialog"
              aria-labelledby="notification-center-title"
              aria-modal="true"
            >
              <div className="flex items-center justify-between p-4 border-b border-border">
                <h2 id="notification-center-title" className="text-lg font-semibold">
                  Notifications
                </h2>
                <div className="flex items-center gap-2">
                  {notifications.length > 0 && (
                    <>
                      {unreadCount > 0 && (
                        <Button
                          variant="ghost"
                          size="sm"
                          onClick={handleMarkAllAsRead}
                          className="text-xs h-8"
                        >
                          <CheckCheck className="h-3 w-3 mr-1" />
                          Mark All Read
                        </Button>
                      )}
                      <Button
                        variant="ghost"
                        size="sm"
                        onClick={handleClearAll}
                        className="text-xs h-8"
                      >
                        Clear All
                      </Button>
                    </>
                  )}
                  <Button
                    variant="ghost"
                    size="icon"
                    className="h-8 w-8"
                    onClick={() => setIsOpen(false)}
                    aria-label="Close notifications"
                  >
                    <X className="h-4 w-4" />
                  </Button>
                </div>
              </div>

              <ScrollArea className="max-h-[500px]">
                {notifications.length === 0 ? (
                  <div className="p-8 text-center text-muted-foreground">
                    <Bell className="h-12 w-12 mx-auto mb-4 opacity-50" />
                    <p className="text-sm">No notifications</p>
                    <p className="text-xs mt-1">You're all caught up!</p>
                  </div>
                ) : (
                  <div className="p-2">
                    {notifications.map((notif, index) => (
                      <motion.div
                        key={notif.id}
                        initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0, x: 20 }}
                        animate={prefersReducedMotion ? {} : { opacity: 1, x: 0 }}
                        transition={{
                          duration: prefersReducedMotion ? 0 : 0.2,
                          delay: prefersReducedMotion ? 0 : index * 0.05,
                        }}
                        className={cn(
                          'relative p-4 mb-2 rounded-lg border transition-colors',
                          getNotificationColor(notif.type),
                          'hover:shadow-md',
                          !notif.read && 'ring-2 ring-primary/20',
                          notif.actionUrl && 'cursor-pointer'
                        )}
                        onClick={() => handleNotificationClick(notif)}
                      >
                        {!notif.read && (
                          <div className="absolute top-2 right-2 h-2 w-2 rounded-full bg-primary" />
                        )}
                        <div className="flex items-start gap-3">
                          <div className="flex-shrink-0 mt-0.5">
                            {getNotificationIcon(notif.type)}
                          </div>
                          <div className="flex-1 min-w-0">
                            <div className="flex items-start justify-between gap-2">
                              <h3 className="text-sm font-semibold text-foreground">
                                {notif.title}
                              </h3>
                              <Button
                                variant="ghost"
                                size="icon"
                                className="h-6 w-6 flex-shrink-0"
                                onClick={(e) => {
                                  e.stopPropagation();
                                  removeNotification(notif.id);
                                }}
                                aria-label="Remove notification"
                              >
                                <X className="h-3 w-3" />
                              </Button>
                            </div>
                            <p className="text-sm text-muted-foreground mt-1">
                              {notif.message}
                            </p>
                            <p className="text-xs text-muted-foreground mt-2">
                              {formatDistanceToNow(new Date(notif.timestamp), { addSuffix: true })}
                            </p>
                          </div>
                        </div>
                      </motion.div>
                    ))}
                  </div>
                )}
              </ScrollArea>
            </motion.div>
          </>
        )}
      </AnimatePresence>
    </div>
  );
}

