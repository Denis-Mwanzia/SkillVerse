import { TrendingUp, TrendingDown, Minus, ArrowRight } from 'lucide-react';
import { motion } from 'framer-motion';
import { Button } from '@/components/ui/button';
import { formatCurrency, formatNumber } from '@/utils/formatters';
import { useReducedMotion } from '@/utils/motion';
import { cn } from '@/lib/utils';
import type { TrendSignal } from '@/types/api';
import { Link } from 'react-router-dom';

interface TrendingSkillsProps {
  trends: TrendSignal[];
}

const trendIcons = {
  rising: <TrendingUp className="h-4 w-4 text-primary" />,
  stable: <Minus className="h-4 w-4 text-muted-foreground" />,
  declining: <TrendingDown className="h-4 w-4 text-destructive" />,
};

export function TrendingSkills({ trends }: TrendingSkillsProps) {
  const prefersReducedMotion = useReducedMotion();
  
  return (
    <motion.div
      initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: prefersReducedMotion ? 0 : 0.4, delay: prefersReducedMotion ? 0 : 0.2 }}
      className="group relative rounded-xl border border-border bg-gradient-to-br from-card to-card/50 p-6 shadow-sm hover:shadow-lg transition-all duration-300"
    >
      {/* Decorative accent */}
      <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-primary via-primary/50 to-transparent rounded-t-xl" />
      
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 sm:gap-4 mb-6">
        <div>
          <h2 className="text-lg sm:text-xl font-bold text-card-foreground mb-1">Trending Skills</h2>
          <p className="text-xs sm:text-sm text-muted-foreground">Skills in high demand right now</p>
        </div>
        <Button variant="ghost" size="sm" asChild className="group/btn w-full sm:w-auto">
          <Link to="/trends" className="flex items-center justify-center gap-1 text-primary hover:gap-2 transition-all">
            View All <ArrowRight className="h-4 w-4 group-hover/btn:translate-x-1 transition-transform" />
          </Link>
        </Button>
      </div>
      
      <div className="space-y-2">
        {trends.slice(0, 5).map((trend, index) => (
          <motion.div
            key={trend.id}
            initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0, x: -10 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ 
              duration: prefersReducedMotion ? 0 : 0.3, 
              delay: prefersReducedMotion ? 0 : 0.3 + index * 0.05 
            }}
            whileHover={prefersReducedMotion ? {} : { x: 4, scale: 1.01 }}
            className="group/item relative flex items-center justify-between p-4 rounded-lg bg-background/50 hover:bg-accent/50 border border-transparent hover:border-border transition-all duration-200 cursor-pointer overflow-hidden"
          >
            {/* Hover gradient effect */}
            <div className="absolute inset-0 bg-gradient-to-r from-primary/0 via-primary/0 to-primary/0 group-hover/item:from-primary/5 group-hover/item:via-primary/5 group-hover/item:to-primary/0 transition-all duration-300" />
            
            <div className="relative flex items-center gap-3 sm:gap-4 flex-1 min-w-0">
              <motion.div
                whileHover={prefersReducedMotion ? {} : { scale: 1.1, rotate: 5 }}
                className="flex items-center justify-center w-9 h-9 sm:w-10 sm:h-10 rounded-xl bg-gradient-to-br from-primary/20 to-primary/10 group-hover/item:from-primary/30 group-hover/item:to-primary/20 transition-all duration-200 flex-shrink-0"
              >
                {trendIcons[trend.trend]}
              </motion.div>
              <div className="flex-1 min-w-0">
                <p className="font-semibold text-sm sm:text-base text-card-foreground mb-1 truncate">{trend.skillName}</p>
                <div className="flex flex-wrap items-center gap-2 sm:gap-3 text-xs text-muted-foreground">
                  <span className="flex items-center gap-1">
                    <span className="w-1.5 h-1.5 rounded-full bg-primary" />
                    {formatNumber(trend.jobCount)} jobs
                  </span>
                  <span className="hidden sm:inline">•</span>
                  <span>{formatCurrency(trend.avgSalary)} avg</span>
                </div>
              </div>
            </div>
            <div className="relative text-right ml-2 sm:ml-4 flex-shrink-0">
              <div className={cn(
                'inline-flex items-center gap-1.5 px-2 sm:px-3 py-1 sm:py-1.5 rounded-lg font-semibold text-xs sm:text-sm',
                trend.growthRate >= 0 
                  ? 'bg-primary/10 text-primary' 
                  : 'bg-destructive/10 text-destructive'
              )}>
                {trend.growthRate >= 0 ? '+' : ''}{trend.growthRate}%
              </div>
              <p className="text-[10px] sm:text-xs text-muted-foreground mt-0.5 sm:mt-1 hidden sm:block">growth rate</p>
            </div>
          </motion.div>
        ))}
      </div>
    </motion.div>
  );
}
