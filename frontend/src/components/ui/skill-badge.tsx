import { cn } from '@/lib/utils';

interface SkillBadgeProps {
  name: string;
  level?: number;
  proficiency?: 'beginner' | 'intermediate' | 'advanced' | 'expert';
  size?: 'sm' | 'md' | 'lg';
  showLevel?: boolean;
  className?: string;
}

const proficiencyColors = {
  beginner: 'bg-muted text-muted-foreground',
  intermediate: 'bg-chart-3/20 text-chart-3',
  advanced: 'bg-chart-1/20 text-chart-1',
  expert: 'bg-primary/20 text-primary',
};

const sizeClasses = {
  sm: 'px-2 py-0.5 text-xs',
  md: 'px-3 py-1 text-sm',
  lg: 'px-4 py-1.5 text-base',
};

export function SkillBadge({ 
  name, 
  level, 
  proficiency = 'intermediate',
  size = 'md',
  showLevel = false,
  className 
}: SkillBadgeProps) {
  return (
    <span
      className={cn(
        'inline-flex items-center gap-1.5 rounded-full font-medium transition-colors',
        proficiencyColors[proficiency],
        sizeClasses[size],
        className
      )}
    >
      {name}
      {showLevel && level !== undefined && (
        <span className="opacity-70">({level}%)</span>
      )}
    </span>
  );
}
