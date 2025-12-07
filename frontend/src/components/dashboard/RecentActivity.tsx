import { Brain, BookOpen, Sparkles, Trophy } from 'lucide-react';
import { motion } from 'framer-motion';
import { formatRelativeTime } from '@/utils/formatters';
import { useReducedMotion } from '@/utils/motion';
import type { ActivityItem } from '@/types/api';

interface RecentActivityProps {
  activities: ActivityItem[];
}

const activityIcons = {
  skill_added: <Sparkles className="h-4 w-4" />,
  quiz_completed: <Brain className="h-4 w-4" />,
  course_completed: <BookOpen className="h-4 w-4" />,
  milestone_reached: <Trophy className="h-4 w-4" />,
};

const activityColors = {
  skill_added: 'bg-chart-2/20 text-chart-2',
  quiz_completed: 'bg-chart-1/20 text-chart-1',
  course_completed: 'bg-primary/20 text-primary',
  milestone_reached: 'bg-chart-4/20 text-chart-4',
};

export function RecentActivity({ activities }: RecentActivityProps) {
  const prefersReducedMotion = useReducedMotion();
  
  return (
    <motion.div
      initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: prefersReducedMotion ? 0 : 0.4, delay: prefersReducedMotion ? 0 : 0.3 }}
      className="group relative rounded-xl border border-border bg-gradient-to-br from-card to-card/50 p-6 shadow-sm hover:shadow-lg transition-all duration-300"
    >
      {/* Decorative accent */}
      <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-chart-1 via-chart-2 to-transparent rounded-t-xl" />
      
      <div className="mb-6">
        <h2 className="text-xl font-bold text-card-foreground mb-1">Recent Activity</h2>
        <p className="text-sm text-muted-foreground">Your latest achievements and updates</p>
      </div>
      
      <div className="space-y-3">
        {activities.map((activity, index) => (
          <motion.div
            key={activity.id}
            initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0, x: -10 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ 
              duration: prefersReducedMotion ? 0 : 0.3, 
              delay: prefersReducedMotion ? 0 : 0.4 + index * 0.05 
            }}
            whileHover={prefersReducedMotion ? {} : { x: 4, scale: 1.01 }}
            className="group/item relative flex items-start gap-4 p-4 rounded-lg bg-background/50 hover:bg-accent/50 border border-transparent hover:border-border transition-all duration-200 cursor-pointer overflow-hidden"
          >
            {/* Timeline connector */}
            {index < activities.length - 1 && (
              <div className="absolute left-7 top-12 w-0.5 h-full bg-border" />
            )}
            
            {/* Icon with glow effect */}
            <motion.div
              whileHover={prefersReducedMotion ? {} : { scale: 1.1, rotate: 5 }}
              className={`relative z-10 p-2.5 rounded-xl ${activityColors[activity.type]} shadow-sm group-hover/item:shadow-md transition-all duration-200`}
            >
              {activityIcons[activity.type]}
              <div className="absolute inset-0 rounded-xl bg-current opacity-0 group-hover/item:opacity-20 blur-md transition-opacity duration-200" />
            </motion.div>
            
            <div className="flex-1 min-w-0 pt-0.5">
              <p className="font-semibold text-card-foreground mb-1 group-hover/item:text-primary transition-colors">
                {activity.title}
              </p>
              <p className="text-sm text-muted-foreground line-clamp-2">{activity.description}</p>
            </div>
            
            <motion.span
              whileHover={prefersReducedMotion ? {} : { scale: 1.05 }}
              className="text-xs text-muted-foreground whitespace-nowrap px-2 py-1 rounded-md bg-muted/50 font-medium"
            >
              {formatRelativeTime(activity.timestamp)}
            </motion.span>
          </motion.div>
        ))}
      </div>
    </motion.div>
  );
}
