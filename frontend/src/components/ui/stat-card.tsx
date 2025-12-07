import { cn } from '@/lib/utils';
import { motion } from 'framer-motion';
import { useReducedMotion } from '@/utils/motion';
import { TrendingUp, TrendingDown } from 'lucide-react';

interface StatCardProps {
  title: string;
  value: string | number;
  subtitle?: string;
  icon?: React.ReactNode;
  trend?: {
    value: number;
    isPositive: boolean;
  };
  className?: string;
  variant?: 'default' | 'gradient' | 'minimal';
  progress?: number; // 0-100 for progress indicator
}

export function StatCard({ 
  title, 
  value, 
  subtitle, 
  icon, 
  trend, 
  className,
  variant = 'default',
  progress,
}: StatCardProps) {
  const prefersReducedMotion = useReducedMotion();
  
  const variantStyles = {
    default: 'bg-card border-border',
    gradient: 'bg-gradient-to-br from-card to-card/50 border-border/50 shadow-lg',
    minimal: 'bg-card/50 border-border/50 backdrop-blur-sm',
  };

  return (
    <motion.div
      whileHover={prefersReducedMotion ? {} : { y: -4, scale: 1.02 }}
      transition={{ duration: 0.2 }}
      className={cn(
        'group relative rounded-xl border p-6 transition-all duration-300',
        'hover:shadow-lg hover:shadow-primary/5',
        variantStyles[variant],
        className
      )}
    >
      {/* Decorative gradient overlay on hover */}
      <div className="absolute inset-0 rounded-xl bg-gradient-to-br from-primary/0 via-primary/0 to-primary/0 group-hover:from-primary/5 group-hover:via-primary/5 group-hover:to-primary/5 transition-all duration-300 pointer-events-none" />
      
      <div className="relative flex items-start justify-between h-full">
        <div className="flex-1 min-w-0 flex flex-col h-full">
          <div className="flex items-center gap-2 mb-3 min-h-[20px]">
            <p className="text-xs font-medium text-muted-foreground uppercase tracking-wide">{title}</p>
            {trend && (
              <motion.div
                initial={false}
                animate={{ scale: trend.isPositive ? [1, 1.1, 1] : 1 }}
                transition={{ duration: 0.3 }}
                className={cn(
                  'flex items-center gap-1 px-1.5 py-0.5 rounded-md text-xs font-semibold',
                  trend.isPositive 
                    ? 'bg-primary/10 text-primary' 
                    : 'bg-destructive/10 text-destructive'
                )}
              >
                {trend.isPositive ? (
                  <TrendingUp className="h-3 w-3" />
                ) : (
                  <TrendingDown className="h-3 w-3" />
                )}
                {Math.abs(trend.value)}%
              </motion.div>
            )}
          </div>
          
          <motion.p
            initial={false}
            animate={{ scale: prefersReducedMotion ? 1 : [1, 1.05, 1] }}
            transition={{ duration: 0.3, delay: 0.1 }}
            className="text-4xl font-bold text-card-foreground tracking-tight mb-2"
          >
            {value}
          </motion.p>
          
          <div className="min-h-[20px] mb-3">
            {subtitle && (
              <p className="text-sm text-muted-foreground">{subtitle}</p>
            )}
          </div>

          {/* Progress bar - always shown to maintain consistent height */}
          <div className="mt-auto pt-2">
            {progress !== undefined ? (
              <>
                <div className="h-1.5 w-full rounded-full bg-muted overflow-hidden">
                  <motion.div
                    initial={{ width: 0 }}
                    animate={{ width: `${progress}%` }}
                    transition={{ duration: 0.8, delay: 0.2, ease: 'easeOut' }}
                    className="h-full bg-gradient-to-r from-primary to-primary/60 rounded-full"
                  />
                </div>
                <p className="text-xs text-muted-foreground mt-1">{Math.round(progress)}% complete</p>
              </>
            ) : (
              <div className="h-[18px]"></div>
            )}
          </div>
        </div>
        
        {icon && (
          <motion.div
            whileHover={prefersReducedMotion ? {} : { rotate: 5, scale: 1.1 }}
            transition={{ duration: 0.2 }}
            className={cn(
              'relative rounded-xl p-3 transition-all duration-300 flex-shrink-0',
              'bg-gradient-to-br from-primary/10 to-primary/5',
              'text-primary shadow-sm',
              'group-hover:from-primary/20 group-hover:to-primary/10',
              'group-hover:shadow-md'
            )}
          >
            {icon}
            {/* Icon glow effect */}
            <div className="absolute inset-0 rounded-xl bg-primary/20 opacity-0 group-hover:opacity-100 blur-xl transition-opacity duration-300 -z-10" />
          </motion.div>
        )}
      </div>
    </motion.div>
  );
}
