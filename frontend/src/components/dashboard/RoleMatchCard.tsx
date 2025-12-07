import { Link } from 'react-router-dom';
import { ArrowRight, TrendingUp, MapPin, DollarSign } from 'lucide-react';
import { motion } from 'framer-motion';
import { Button } from '@/components/ui/button';
import { ProgressRing } from '@/components/ui/progress-ring';
import { SkillBadge } from '@/components/ui/skill-badge';
import { formatCurrency } from '@/utils/formatters';
import { useReducedMotion } from '@/utils/motion';
import { cn } from '@/lib/utils';
import type { RoleRecommendation } from '@/types/api';

interface RoleMatchCardProps {
  recommendation: RoleRecommendation;
  index?: number;
}

export function RoleMatchCard({ recommendation, index = 0 }: RoleMatchCardProps) {
  const prefersReducedMotion = useReducedMotion();
  const matchColor = recommendation.matchScore >= 80 ? 'text-primary' : recommendation.matchScore >= 60 ? 'text-chart-3' : 'text-chart-4';
  
  return (
    <motion.div
      initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0, y: 20, scale: 0.95 }}
      animate={{ opacity: 1, y: 0, scale: 1 }}
      transition={{ 
        duration: prefersReducedMotion ? 0 : 0.4, 
        delay: prefersReducedMotion ? 0 : 0.4 + index * 0.1,
        type: 'spring',
        stiffness: 100,
      }}
      whileHover={prefersReducedMotion ? {} : { y: -4, scale: 1.01 }}
      className="group relative rounded-xl border border-border bg-gradient-to-br from-card to-card/50 p-6 shadow-sm hover:shadow-xl transition-all duration-300 overflow-hidden"
    >
      {/* Decorative gradient overlay */}
      <div className="absolute inset-0 bg-gradient-to-br from-primary/0 via-primary/0 to-primary/0 group-hover:from-primary/5 group-hover:via-primary/5 group-hover:to-primary/5 transition-all duration-300 pointer-events-none" />
      
      {/* Top accent bar */}
      <div className={cn('absolute top-0 left-0 right-0 h-1 rounded-t-xl', 
        recommendation.matchScore >= 80 ? 'bg-gradient-to-r from-primary to-primary/50' :
        recommendation.matchScore >= 60 ? 'bg-gradient-to-r from-chart-3 to-chart-3/50' :
        'bg-gradient-to-r from-chart-4 to-chart-4/50'
      )} />
      <div className="relative flex flex-col sm:flex-row gap-4 sm:gap-6">
        {/* Match Score Circle */}
        <div className="flex-shrink-0 relative flex justify-center sm:justify-start">
          <motion.div
            whileHover={prefersReducedMotion ? {} : { scale: 1.05 }}
            transition={{ duration: 0.2 }}
          >
            <div className="w-[100px] h-[100px] sm:w-[120px] sm:h-[120px]">
              <ProgressRing 
                value={recommendation.matchScore} 
                size={100}
                className={cn(matchColor, "w-full h-full")}
              >
                <div className="text-center">
                  <motion.span
                    initial={false}
                    animate={{ scale: prefersReducedMotion ? 1 : [1, 1.1, 1] }}
                    transition={{ duration: 0.3, delay: 0.2 }}
                    className={cn('text-xl sm:text-2xl font-bold', matchColor)}
                  >
                    {recommendation.matchScore}%
                  </motion.span>
                  <p className="text-[10px] sm:text-xs text-muted-foreground mt-0.5 sm:mt-1 font-medium">match</p>
                </div>
              </ProgressRing>
            </div>
          </motion.div>
          
          {/* Growth potential indicator */}
          {recommendation.growthPotential >= 8 && (
            <div className="absolute -top-2 -right-2 flex items-center gap-1 px-2 py-1 bg-chart-2/20 text-chart-2 rounded-full text-xs font-semibold">
              <TrendingUp className="h-3 w-3" />
              High Growth
            </div>
          )}
        </div>
        
        <div className="flex-1 min-w-0 space-y-4">
          {/* Header */}
          <div className="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-3 sm:gap-4">
            <div className="flex-1 min-w-0">
              <h3 className="text-lg sm:text-xl font-bold text-card-foreground mb-1 group-hover:text-primary transition-colors">
                {recommendation.title}
              </h3>
              {recommendation.company && (
                <div className="flex items-center gap-1.5 text-xs sm:text-sm text-muted-foreground mb-2">
                  <MapPin className="h-3.5 w-3.5" />
                  {recommendation.company}
                </div>
              )}
              <div className="flex flex-wrap items-center gap-2">
                <DollarSign className="h-4 w-4 text-chart-3" />
                <p className="text-base sm:text-lg font-bold text-primary">
                  {formatCurrency(recommendation.salary.min)} - {formatCurrency(recommendation.salary.max)}
                </p>
                <span className="text-xs text-muted-foreground">/year</span>
              </div>
            </div>
            <Button variant="outline" size="sm" asChild className="group/btn w-full sm:w-auto">
              <Link to={`/gap-analysis?role=${recommendation.id}`} className="flex items-center justify-center gap-1">
                Analyze <ArrowRight className="h-4 w-4 group-hover/btn:translate-x-1 transition-transform" />
              </Link>
            </Button>
          </div>
          
          {/* Skills Section */}
          <div className="space-y-3 pt-2 border-t border-border/50">
            <div>
              <p className="text-xs font-semibold text-muted-foreground uppercase tracking-wide mb-2">
                Matching Skills ({recommendation.matchingSkills.length})
              </p>
              <div className="flex flex-wrap gap-2">
                {recommendation.matchingSkills.map((skill) => (
                  <SkillBadge 
                    key={skill} 
                    name={skill} 
                    proficiency="advanced" 
                    size="sm"
                    className="transition-transform hover:scale-105"
                  />
                ))}
              </div>
            </div>
            {recommendation.missingSkills.length > 0 && (
              <div>
                <p className="text-xs font-semibold text-muted-foreground uppercase tracking-wide mb-2">
                  Skills to Learn ({recommendation.missingSkills.length})
                </p>
                <div className="flex flex-wrap gap-2">
                  {recommendation.missingSkills.map((skill) => (
                    <SkillBadge 
                      key={skill} 
                      name={skill} 
                      proficiency="beginner" 
                      size="sm"
                      className="transition-transform hover:scale-105 opacity-75"
                    />
                  ))}
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    </motion.div>
  );
}
