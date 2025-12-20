import { ArrowUpDown, Plus, Brain } from 'lucide-react';
import { motion } from 'framer-motion';
import { Button } from '@/components/ui/button';
import { Progress } from '@/components/ui/progress';
import { cn } from '@/lib/utils';
import type { GapAnalysisItem } from '@/types/api';

interface GapTableProps {
  gaps: GapAnalysisItem[];
  onAddToLearning: (skillId: string) => void;
  onStartQuiz: (skillId: string) => void;
}

const severityColors = {
  critical: 'bg-destructive/20 text-destructive',
  high: 'bg-chart-4/20 text-chart-4',
  medium: 'bg-chart-3/20 text-chart-3',
  low: 'bg-primary/20 text-primary',
};

export function GapTable({ gaps, onAddToLearning, onStartQuiz }: GapTableProps) {
  return (
    <div className="rounded-lg border border-border bg-card overflow-hidden">
      {/* Header */}
      <div className="grid grid-cols-12 gap-4 p-4 bg-muted/30 border-b border-border text-sm font-medium text-muted-foreground">
        <div className="col-span-3 flex items-center gap-1 cursor-pointer hover:text-foreground">
          Skill <ArrowUpDown className="h-3 w-3" />
        </div>
        <div className="col-span-2">Current</div>
        <div className="col-span-2">Required</div>
        <div className="col-span-2 flex items-center gap-1 cursor-pointer hover:text-foreground">
          Gap <ArrowUpDown className="h-3 w-3" />
        </div>
        <div className="col-span-3">Actions</div>
      </div>

      {/* Body */}
      <div className="divide-y divide-border">
        {gaps.map((gap, index) => (
          <motion.div
            key={gap.skillId}
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.2, delay: index * 0.05 }}
            className="grid grid-cols-12 gap-4 p-4 items-center hover:bg-accent/30 transition-colors"
          >
            <div className="col-span-3">
              <div className="flex items-center gap-2">
                <span className="font-medium text-card-foreground">{gap.skillName}</span>
                <span
                  className={cn(
                    'px-2 py-0.5 rounded-full text-xs font-medium',
                    severityColors[gap.severity]
                  )}
                >
                  {gap.severity}
                </span>
              </div>
              <p className="text-xs text-muted-foreground mt-0.5">{gap.learningTime}</p>
            </div>

            <div className="col-span-2">
              <div className="flex items-center gap-2">
                <Progress value={gap.currentLevel} className="h-2 flex-1" />
                <span className="text-sm text-muted-foreground">{gap.currentLevel}%</span>
              </div>
            </div>

            <div className="col-span-2">
              <div className="flex items-center gap-2">
                <Progress value={gap.requiredLevel} className="h-2 flex-1" />
                <span className="text-sm text-muted-foreground">{gap.requiredLevel}%</span>
              </div>
            </div>

            <div className="col-span-2">
              <div className="flex items-center gap-2">
                <div className="h-2 w-full bg-destructive/20 rounded-full overflow-hidden">
                  <div
                    className="h-full bg-destructive transition-all"
                    style={{ width: `${(gap.gap / gap.requiredLevel) * 100}%` }}
                  />
                </div>
                <span className="text-sm font-medium text-destructive">-{gap.gap}%</span>
              </div>
            </div>

            <div className="col-span-3 flex items-center gap-2">
              <Button
                variant="outline"
                size="sm"
                onClick={() => onAddToLearning(gap.skillId)}
              >
                <Plus className="h-3 w-3 mr-1" />
                Learn
              </Button>
              <Button
                variant="ghost"
                size="sm"
                onClick={() => onStartQuiz(gap.skillId)}
              >
                <Brain className="h-3 w-3 mr-1" />
                Quiz
              </Button>
            </div>
          </motion.div>
        ))}
      </div>
    </div>
  );
}
