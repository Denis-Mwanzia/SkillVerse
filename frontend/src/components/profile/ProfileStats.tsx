import { TrendingUp, BookOpen, Brain, Trophy, Target, Award } from 'lucide-react';
import { Card, CardContent } from '@/components/ui/card';
import { motion } from 'framer-motion';
import { useReducedMotion } from '@/utils/motion';
import { cn } from '@/lib/utils';
import { useQuery } from '@tanstack/react-query';
import { dashboardApi } from '@/api/dashboard';
import { Skeleton } from '@/components/ui/skeleton';

interface StatItemProps {
  icon: React.ReactNode;
  label: string;
  value: string | number;
  trend?: { value: number; isPositive: boolean };
  className?: string;
}

function StatItem({ icon, label, value, trend, className }: StatItemProps) {
  const prefersReducedMotion = useReducedMotion();
  
  return (
    <motion.div
      whileHover={prefersReducedMotion ? {} : { scale: 1.02, y: -2 }}
      className={cn('p-4 rounded-lg border border-border bg-card', className)}
    >
      <div className="flex items-start justify-between">
        <div className="flex-1">
          <p className="text-sm text-muted-foreground mb-1">{label}</p>
          <p className="text-2xl font-bold text-card-foreground">{value}</p>
          {trend && (
            <div className={cn(
              'flex items-center gap-1 mt-2 text-xs font-medium',
              trend.isPositive ? 'text-primary' : 'text-destructive'
            )}>
              <TrendingUp className={cn('h-3 w-3', !trend.isPositive && 'rotate-180')} />
              {trend.isPositive ? '+' : ''}{trend.value}%
            </div>
          )}
        </div>
        <div className="p-3 rounded-lg bg-primary/10 text-primary">{icon}</div>
      </div>
    </motion.div>
  );
}

export function ProfileStats() {
  const prefersReducedMotion = useReducedMotion();
  const { data, isLoading } = useQuery({
    queryKey: ['dashboard', 'user_1'],
    queryFn: () => dashboardApi.getDashboard('user_1'),
  });

  if (isLoading) {
    return (
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        {[...Array(6)].map((_, i) => (
          <Skeleton key={i} className="h-32 rounded-lg" />
        ))}
      </div>
    );
  }

  const stats = data?.stats;

  if (!stats) return null;

  const statItems = [
    {
      icon: <Target className="h-5 w-5" />,
      label: 'Total Skills',
      value: stats.totalSkills,
      trend: { value: stats.skillGrowth, isPositive: true },
    },
    {
      icon: <BookOpen className="h-5 w-5" />,
      label: 'Courses Completed',
      value: stats.completedCourses,
    },
    {
      icon: <Brain className="h-5 w-5" />,
      label: 'Quizzes Taken',
      value: stats.quizzesTaken,
    },
    {
      icon: <Trophy className="h-5 w-5" />,
      label: 'Average Score',
      value: `${stats.averageScore}%`,
    },
    {
      icon: <Award className="h-5 w-5" />,
      label: 'Learning Streak',
      value: `${stats.streak} days`,
    },
    {
      icon: <TrendingUp className="h-5 w-5" />,
      label: 'Skill Growth',
      value: `+${stats.skillGrowth}%`,
      trend: { value: stats.skillGrowth, isPositive: true },
    },
  ];

  return (
    <motion.div
      initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: prefersReducedMotion ? 0 : 0.4, delay: 0.2 }}
      className="space-y-4"
    >
      <h2 className="text-xl font-semibold text-foreground">Your Statistics</h2>
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        {statItems.map((stat, index) => (
          <motion.div
            key={stat.label}
            initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: prefersReducedMotion ? 0 : 0.3, delay: 0.3 + index * 0.05 }}
          >
            <StatItem {...stat} />
          </motion.div>
        ))}
      </div>
    </motion.div>
  );
}

