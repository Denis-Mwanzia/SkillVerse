import { TrendingUp, BookOpen, Brain, Flame, Award, Target } from 'lucide-react';
import { motion } from 'framer-motion';
import { StatCard } from '@/components/ui/stat-card';
import { useReducedMotion } from '@/utils/motion';
import type { DashboardStats } from '@/types/api';

interface HeroStatsProps {
  stats: DashboardStats;
}

export function HeroStats({ stats }: HeroStatsProps) {
  const prefersReducedMotion = useReducedMotion();
  
  const statCards = [
    {
      title: 'Total Skills',
      value: stats.totalSkills,
      subtitle: `+${stats.skillGrowth}% this month`,
      icon: <TrendingUp className="h-5 w-5" />,
      trend: { value: stats.skillGrowth, isPositive: true },
      variant: 'gradient' as const,
      progress: Math.min((stats.totalSkills / 50) * 100, 100), // Assuming 50 is a good milestone
    },
    {
      title: 'Completed Courses',
      value: stats.completedCourses,
      subtitle: 'Keep up the momentum!',
      icon: <BookOpen className="h-5 w-5" />,
      trend: undefined,
      variant: 'gradient' as const,
      progress: Math.min((stats.completedCourses / 20) * 100, 100),
    },
    {
      title: 'Quiz Average',
      value: `${stats.averageScore}%`,
      subtitle: `${stats.quizzesTaken} quizzes taken`,
      icon: <Brain className="h-5 w-5" />,
      trend: undefined,
      variant: 'gradient' as const,
      progress: stats.averageScore,
    },
    {
      title: 'Learning Streak',
      value: `${stats.streak} days`,
      subtitle: 'Personal best: 14 days',
      icon: <Flame className="h-5 w-5" />,
      trend: undefined,
      variant: 'gradient' as const,
      progress: Math.min((stats.streak / 30) * 100, 100), // Assuming 30 days is a milestone
    },
  ];

  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 lg:gap-6 auto-rows-fr">
      {statCards.map((stat, index) => (
        <motion.div
          key={stat.title}
          initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0, y: 20, scale: 0.95 }}
          animate={{ opacity: 1, y: 0, scale: 1 }}
          transition={{ 
            duration: prefersReducedMotion ? 0 : 0.4, 
            delay: prefersReducedMotion ? 0 : index * 0.1,
            type: 'spring',
            stiffness: 100,
          }}
          className="h-full"
        >
          <StatCard {...stat} className="h-full flex flex-col" />
        </motion.div>
      ))}
    </div>
  );
}
