import { useState } from 'react';
import { Camera, Check } from 'lucide-react';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Button } from '@/components/ui/button';
import { motion } from 'framer-motion';
import { useReducedMotion } from '@/utils/motion';
import { cn } from '@/lib/utils';
import type { User } from '@/types/api';

interface ProfileHeaderProps {
  user: User;
  onAvatarChange?: (file: File) => Promise<void>;
  isEditing?: boolean;
}

export function ProfileHeader({ user, onAvatarChange, isEditing = false }: ProfileHeaderProps) {
  const prefersReducedMotion = useReducedMotion();
  const [avatarPreview, setAvatarPreview] = useState<string | null>(null);
  const [isUploading, setIsUploading] = useState(false);

  const handleAvatarClick = () => {
    if (!onAvatarChange || !isEditing) return;
    const input = document.createElement('input');
    input.type = 'file';
    input.accept = 'image/*';
    input.onchange = async (e) => {
      const file = (e.target as HTMLInputElement).files?.[0];
      if (file) {
        const preview = URL.createObjectURL(file);
        setAvatarPreview(preview);
        setIsUploading(true);
        try {
          await onAvatarChange(file);
        } finally {
          setIsUploading(false);
        }
      }
    };
    input.click();
  };

  return (
    <motion.div
      initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: prefersReducedMotion ? 0 : 0.4 }}
      className="relative"
    >
      <div className="rounded-xl border border-border bg-gradient-to-br from-card to-card/50 p-4 sm:p-6 md:p-8">
        <div className="flex flex-col sm:flex-row items-center sm:items-start gap-4 sm:gap-6">
          <div className="relative group">
            <Avatar className="h-24 w-24 sm:h-28 sm:w-28 md:h-32 md:w-32 border-4 border-card shadow-lg">
              <AvatarImage src={avatarPreview || user.avatar} alt={user.name} />
              <AvatarFallback className="bg-primary text-primary-foreground text-2xl sm:text-3xl md:text-4xl">
                {user.name?.charAt(0)?.toUpperCase() || 'U'}
              </AvatarFallback>
            </Avatar>
            {isEditing && onAvatarChange && (
              <motion.button
                whileHover={prefersReducedMotion ? {} : { scale: 1.1 }}
                whileTap={prefersReducedMotion ? {} : { scale: 0.95 }}
                onClick={handleAvatarClick}
                disabled={isUploading}
                className={cn(
                  'absolute bottom-0 right-0 rounded-full p-2 sm:p-2.5 md:p-3 bg-primary text-primary-foreground',
                  'shadow-lg hover:shadow-xl transition-shadow',
                  'disabled:opacity-50 disabled:cursor-not-allowed'
                )}
                aria-label="Change avatar"
              >
                {isUploading ? (
                  <div className="h-4 w-4 sm:h-5 sm:w-5 border-2 border-primary-foreground border-t-transparent rounded-full animate-spin" />
                ) : (
                  <Camera className="h-4 w-4 sm:h-5 sm:w-5" />
                )}
              </motion.button>
            )}
          </div>

          <div className="flex-1 text-center sm:text-left space-y-2 w-full min-w-0">
            <h1 className="text-2xl sm:text-3xl font-bold text-card-foreground truncate">{user.name}</h1>
            <p className="text-sm sm:text-base text-muted-foreground truncate">{user.email}</p>
            <div className="flex flex-wrap items-center justify-center sm:justify-start gap-3 sm:gap-4 pt-2">
              <div className="flex items-center gap-2 text-xs sm:text-sm">
                <div className="h-2 w-2 rounded-full bg-green-500" />
                <span className="text-muted-foreground">Active</span>
              </div>
              <div className="flex items-center gap-2 text-xs sm:text-sm text-muted-foreground">
                Member since {new Date(user.createdAt).toLocaleDateString('en-US', { month: 'short', year: 'numeric' })}
              </div>
            </div>
          </div>
        </div>
      </div>
    </motion.div>
  );
}

