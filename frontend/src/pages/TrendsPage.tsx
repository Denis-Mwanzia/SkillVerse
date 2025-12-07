import { useQuery } from '@tanstack/react-query';
import { motion } from 'framer-motion';
import { TrendingUp, TrendingDown, Minus } from 'lucide-react';
import { Skeleton } from '@/components/ui/skeleton';
import { formatCurrency, formatNumber } from '@/utils/formatters';
import { trendsApi } from '@/api/trends';
import { cn } from '@/lib/utils';

export default function TrendsPage() {
  const { data, isLoading } = useQuery({
    queryKey: ['trends'],
    queryFn: () => trendsApi.getTrendSignals(),
  });

  if (isLoading) return <Skeleton className="h-96 rounded-lg" />;
  if (!data) return null;

  const trendIcon = { rising: TrendingUp, stable: Minus, declining: TrendingDown };

  return (
    <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-foreground">Market Trends</h1>
        <p className="text-muted-foreground">Real-time skill demand insights</p>
      </div>

      <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
        {data.signals.map((signal, i) => {
          const Icon = trendIcon[signal.trend];
          return (
            <motion.div
              key={signal.id}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: i * 0.05 }}
              className="rounded-lg border border-border bg-card p-6"
            >
              <div className="flex items-center justify-between mb-4">
                <h3 className="font-semibold text-card-foreground">{signal.skillName}</h3>
                <Icon className={cn('h-5 w-5', signal.trend === 'rising' ? 'text-primary' : signal.trend === 'declining' ? 'text-destructive' : 'text-muted-foreground')} />
              </div>
              <div className="grid grid-cols-2 gap-4 text-sm">
                <div><p className="text-muted-foreground">Jobs</p><p className="font-semibold">{formatNumber(signal.jobCount)}</p></div>
                <div><p className="text-muted-foreground">Avg Salary</p><p className="font-semibold">{formatCurrency(signal.avgSalary)}</p></div>
                <div><p className="text-muted-foreground">Growth</p><p className={cn('font-semibold', signal.growthRate >= 0 ? 'text-primary' : 'text-destructive')}>{signal.growthRate >= 0 ? '+' : ''}{signal.growthRate}%</p></div>
                <div><p className="text-muted-foreground">Demand</p><p className="font-semibold">{signal.demandScore}/100</p></div>
              </div>
            </motion.div>
          );
        })}
      </div>
    </motion.div>
  );
}
