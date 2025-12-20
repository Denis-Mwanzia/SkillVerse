import { Clock, Award, ExternalLink } from 'lucide-react';
import { motion } from 'framer-motion';
import { Button } from '@/components/ui/button';
import { cn } from '@/lib/utils';
import type { LearningStep } from '@/types/api';

interface CourseCardProps {
  step: LearningStep;
  onComplete: () => void;
}

const resourceIcons = {
  course: '📚',
  video: '🎬',
  article: '📄',
  project: '🛠️',
  certification: '🏆',
};

export function CourseCard({ step, onComplete }: CourseCardProps) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 10 }}
      animate={{ opacity: 1, y: 0 }}
      className={cn(
        'rounded-lg border bg-card p-6 transition-all',
        step.completed ? 'border-primary/30 opacity-75' : 'border-border hover:border-primary/50'
      )}
    >
      <div className="flex items-start gap-4">
        <div className="text-3xl">{resourceIcons[step.resourceType]}</div>
        <div className="flex-1 min-w-0">
          <h3 className={cn(
            'font-semibold text-lg',
            step.completed ? 'text-muted-foreground line-through' : 'text-card-foreground'
          )}>
            {step.title}
          </h3>
          <p className="text-sm text-muted-foreground mt-1">{step.description}</p>
          
          <div className="flex items-center gap-4 mt-3 text-sm text-muted-foreground">
            <span className="flex items-center gap-1.5">
              <Clock className="h-4 w-4" /> {step.duration}
            </span>
            <span className="flex items-center gap-1.5">
              <Award className="h-4 w-4" /> {step.provider}
            </span>
          </div>

          <div className="flex items-center gap-2 mt-4">
            {step.completed ? (
              <Button variant="outline" size="sm" onClick={onComplete}>
                Mark as Incomplete
              </Button>
            ) : (
              <>
                {step.url && (
                  <Button size="sm" asChild>
                    <a href={step.url} target="_blank" rel="noopener noreferrer">
                      Start Learning <ExternalLink className="h-3 w-3 ml-1" />
                    </a>
                  </Button>
                )}
                <Button variant="outline" size="sm" onClick={onComplete}>
                  Mark Complete
                </Button>
              </>
            )}
          </div>
        </div>
      </div>
    </motion.div>
  );
}
