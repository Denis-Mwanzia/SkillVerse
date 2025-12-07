import { Check, Circle, ExternalLink, Clock, Award } from 'lucide-react';
import { motion } from 'framer-motion';
import { Button } from '@/components/ui/button';
import { cn } from '@/lib/utils';
import type { LearningStep } from '@/types/api';

interface LearningTimelineProps {
  steps: LearningStep[];
  onToggleComplete: (stepId: string, completed: boolean) => void;
}

const resourceIcons = {
  course: '📚',
  video: '🎬',
  article: '📄',
  project: '🛠️',
  certification: '🏆',
};

export function LearningTimeline({ steps, onToggleComplete }: LearningTimelineProps) {
  const completedCount = steps.filter((s) => s.completed).length;
  const progress = (completedCount / steps.length) * 100;

  return (
    <div className="space-y-6">
      {/* Progress Header */}
      <div className="rounded-lg border border-border bg-card p-6">
        <div className="flex items-center justify-between mb-4">
          <div>
            <h3 className="text-lg font-semibold text-card-foreground">Your Progress</h3>
            <p className="text-sm text-muted-foreground">
              {completedCount} of {steps.length} steps completed
            </p>
          </div>
          <div className="text-right">
            <p className="text-2xl font-bold text-primary">{Math.round(progress)}%</p>
            <p className="text-xs text-muted-foreground">Complete</p>
          </div>
        </div>
        <div className="h-2 bg-muted rounded-full overflow-hidden">
          <motion.div
            className="h-full bg-primary"
            initial={{ width: 0 }}
            animate={{ width: `${progress}%` }}
            transition={{ duration: 0.5, ease: 'easeOut' }}
          />
        </div>
      </div>

      {/* Timeline */}
      <div className="relative">
        {/* Vertical line */}
        <div className="absolute left-6 top-0 bottom-0 w-0.5 bg-border" />

        <div className="space-y-4">
          {steps.map((step, index) => (
            <motion.div
              key={step.id}
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.3, delay: index * 0.1 }}
              className={cn(
                'relative flex gap-4 p-4 rounded-lg border transition-all',
                step.completed
                  ? 'border-primary/30 bg-primary/5'
                  : 'border-border bg-card hover:border-primary/50'
              )}
            >
              {/* Timeline node */}
              <button
                onClick={() => onToggleComplete(step.id, !step.completed)}
                className={cn(
                  'relative z-10 flex-shrink-0 w-8 h-8 rounded-full flex items-center justify-center transition-all',
                  step.completed
                    ? 'bg-primary text-primary-foreground'
                    : 'bg-card border-2 border-border hover:border-primary'
                )}
              >
                {step.completed ? (
                  <Check className="h-4 w-4" />
                ) : (
                  <Circle className="h-3 w-3 text-muted-foreground" />
                )}
              </button>

              {/* Content */}
              <div className="flex-1 min-w-0">
                <div className="flex items-start justify-between gap-4">
                  <div>
                    <div className="flex items-center gap-2">
                      <span>{resourceIcons[step.resourceType]}</span>
                      <h4 className={cn(
                        'font-medium',
                        step.completed ? 'text-muted-foreground line-through' : 'text-card-foreground'
                      )}>
                        {step.title}
                      </h4>
                    </div>
                    <p className="text-sm text-muted-foreground mt-1">{step.description}</p>
                    <div className="flex items-center gap-4 mt-2 text-xs text-muted-foreground">
                      <span className="flex items-center gap-1">
                        <Clock className="h-3 w-3" /> {step.duration}
                      </span>
                      <span className="flex items-center gap-1">
                        <Award className="h-3 w-3" /> {step.provider}
                      </span>
                    </div>
                  </div>
                  {step.url && !step.completed && (
                    <Button variant="outline" size="sm" asChild>
                      <a href={step.url} target="_blank" rel="noopener noreferrer">
                        Start <ExternalLink className="h-3 w-3 ml-1" />
                      </a>
                    </Button>
                  )}
                </div>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </div>
  );
}
