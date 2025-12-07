import { cn } from '@/lib/utils';

interface PriorityMeterProps {
  value: number;
  max?: number;
  label?: string;
  size?: 'sm' | 'md' | 'lg';
}

export function PriorityMeter({ value, max = 10, label, size = 'md' }: PriorityMeterProps) {
  const percentage = (value / max) * 100;
  
  const getColor = () => {
    if (percentage >= 80) return 'bg-destructive';
    if (percentage >= 60) return 'bg-chart-4';
    if (percentage >= 40) return 'bg-chart-3';
    return 'bg-primary';
  };

  const sizeClasses = {
    sm: 'h-1.5',
    md: 'h-2',
    lg: 'h-3',
  };

  return (
    <div className="space-y-1">
      {label && (
        <div className="flex items-center justify-between text-sm">
          <span className="text-muted-foreground">{label}</span>
          <span className="font-medium text-card-foreground">{value}/{max}</span>
        </div>
      )}
      <div className={cn('w-full bg-muted rounded-full overflow-hidden', sizeClasses[size])}>
        <div
          className={cn('h-full transition-all duration-500', getColor())}
          style={{ width: `${percentage}%` }}
        />
      </div>
    </div>
  );
}
