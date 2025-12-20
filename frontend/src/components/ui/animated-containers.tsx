import { motion, HTMLMotionProps } from 'framer-motion';
import { cn } from '@/lib/utils';
import { useReducedMotion } from '@/utils/motion';

interface AnimatedCardProps extends HTMLMotionProps<'div'> {
  delay?: number;
}

export function AnimatedCard({ children, className, delay = 0, ...props }: AnimatedCardProps) {
  const prefersReducedMotion = useReducedMotion();
  return (
    <motion.div
      initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0, y: 20 }}
      animate={prefersReducedMotion ? { opacity: 1 } : { opacity: 1, y: 0 }}
      transition={prefersReducedMotion ? { duration: 0 } : { duration: 0.3, delay }}
      className={cn('rounded-lg border border-border bg-card p-6', className)}
      {...props}
    >
      {children}
    </motion.div>
  );
}

export function FadeIn({ children, className, delay = 0, ...props }: AnimatedCardProps) {
  const prefersReducedMotion = useReducedMotion();
  return (
    <motion.div
      initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={prefersReducedMotion ? { duration: 0 } : { duration: 0.4, delay }}
      className={className}
      {...props}
    >
      {children}
    </motion.div>
  );
}

export function SlideIn({ children, className, delay = 0, ...props }: AnimatedCardProps) {
  const prefersReducedMotion = useReducedMotion();
  return (
    <motion.div
      initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0, x: -20 }}
      animate={prefersReducedMotion ? { opacity: 1 } : { opacity: 1, x: 0 }}
      transition={prefersReducedMotion ? { duration: 0 } : { duration: 0.3, delay }}
      className={className}
      {...props}
    >
      {children}
    </motion.div>
  );
}

export function ScaleIn({ children, className, delay = 0, ...props }: AnimatedCardProps) {
  const prefersReducedMotion = useReducedMotion();
  return (
    <motion.div
      initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0, scale: 0.95 }}
      animate={prefersReducedMotion ? { opacity: 1 } : { opacity: 1, scale: 1 }}
      transition={prefersReducedMotion ? { duration: 0 } : { duration: 0.2, delay }}
      className={className}
      {...props}
    >
      {children}
    </motion.div>
  );
}
