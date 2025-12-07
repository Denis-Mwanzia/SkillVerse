import { useQuery } from '@tanstack/react-query';
import { motion } from 'framer-motion';
import { HeroStats, TrendingSkills, RecentActivity, RoleMatchCard } from '@/components/dashboard';
import { Skeleton } from '@/components/ui/skeleton';
import { QueryError } from '@/components/ui/query-error';
import { dashboardApi } from '@/api/dashboard';
import { useReducedMotion } from '@/utils/motion';

export default function Dashboard() {
  const prefersReducedMotion = useReducedMotion();
  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['dashboard', 'user_1'],
    queryFn: () => dashboardApi.getDashboard('user_1'),
  });

  if (isLoading) {
    return (
      <div className="space-y-6">
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          {[...Array(4)].map((_, i) => <Skeleton key={i} className="h-32 rounded-lg" />)}
        </div>
        <Skeleton className="h-64 rounded-lg" />
      </div>
    );
  }

  if (error) {
    return (
      <QueryError 
        error={error} 
        refetch={refetch}
        title="Failed to load dashboard"
        description="We couldn't load your dashboard data. Please try again."
      />
    );
  }

  if (!data) return null;

  return (
    <motion.div 
      initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0 }} 
      animate={{ opacity: 1 }}
      transition={prefersReducedMotion ? { duration: 0 } : { duration: 0.3 }}
      className="space-y-4 sm:space-y-6"
    >
      <div className="px-1">
        <h1 className="text-xl sm:text-2xl font-bold text-foreground">Welcome back, {data.user.name}!</h1>
        <p className="text-sm sm:text-base text-muted-foreground">Here's your career intelligence overview</p>
      </div>

      <HeroStats stats={data.stats} />

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-4 sm:gap-6">
        <TrendingSkills trends={data.trendingSkills} />
        <RecentActivity activities={data.recentActivity} />
      </div>

      {data.recommendations.length > 0 && (
        <div className="px-1">
          <h2 className="text-lg sm:text-xl font-semibold text-foreground mb-4">Recommended for You</h2>
          <RoleMatchCard recommendation={data.recommendations[0]} />
        </div>
      )}
    </motion.div>
  );
}
