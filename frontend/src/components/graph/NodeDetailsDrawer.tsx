import { X, BookOpen, Brain, TrendingUp } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { Button } from '@/components/ui/button';
import { Progress } from '@/components/ui/progress';
import { SkillBadge } from '@/components/ui/skill-badge';
import type { Node } from '@xyflow/react';

interface NodeDetailsDrawerProps {
  node: Node | null;
  onClose: () => void;
  onStartQuiz: (skillId: string) => void;
  onAddToLearning: (skillId: string) => void;
}

export function NodeDetailsDrawer({ node, onClose, onStartQuiz, onAddToLearning }: NodeDetailsDrawerProps) {
  if (!node) return null;

  const data = node.data as { label: string; level: number; category: string; proficiency: string };

  return (
    <AnimatePresence>
      <motion.div
        initial={{ x: '100%' }}
        animate={{ x: 0 }}
        exit={{ x: '100%' }}
        transition={{ type: 'spring', damping: 25, stiffness: 300 }}
        className="fixed right-0 top-0 h-full w-96 max-w-full bg-card border-l border-border shadow-xl z-50"
      >
        <div className="h-full flex flex-col">
          {/* Header */}
          <div className="p-6 border-b border-border">
            <div className="flex items-start justify-between">
              <div>
                <h2 className="text-xl font-bold text-card-foreground">{data.label}</h2>
                <SkillBadge
                  name={data.category}
                  proficiency={data.proficiency as 'beginner' | 'intermediate' | 'advanced' | 'expert'}
                  size="sm"
                  className="mt-2"
                />
              </div>
              <Button variant="ghost" size="icon" onClick={onClose}>
                <X className="h-5 w-5" />
              </Button>
            </div>
          </div>

          {/* Content */}
          <div className="flex-1 overflow-auto p-6 space-y-6">
            {/* Skill Level */}
            <div>
              <div className="flex items-center justify-between mb-2">
                <span className="text-sm font-medium text-card-foreground">Proficiency Level</span>
                <span className="text-sm font-bold text-primary">{data.level}%</span>
              </div>
              <Progress value={data.level} className="h-2" />
              <p className="text-xs text-muted-foreground mt-2">
                {data.level >= 80
                  ? 'Expert level - You can mentor others'
                  : data.level >= 60
                  ? 'Advanced - Strong foundation'
                  : data.level >= 40
                  ? 'Intermediate - Keep practicing'
                  : 'Beginner - Start with fundamentals'}
              </p>
            </div>

            {/* Market Demand */}
            <div className="p-4 rounded-lg bg-background">
              <div className="flex items-center gap-2 mb-3">
                <TrendingUp className="h-4 w-4 text-primary" />
                <span className="text-sm font-medium text-card-foreground">Market Demand</span>
              </div>
              <div className="grid grid-cols-2 gap-4 text-sm">
                <div>
                  <p className="text-muted-foreground">Job Openings</p>
                  <p className="font-semibold text-card-foreground">12,450</p>
                </div>
                <div>
                  <p className="text-muted-foreground">Avg Salary</p>
                  <p className="font-semibold text-card-foreground">$145,000</p>
                </div>
                <div>
                  <p className="text-muted-foreground">Growth</p>
                  <p className="font-semibold text-primary">+18%</p>
                </div>
                <div>
                  <p className="text-muted-foreground">Demand Score</p>
                  <p className="font-semibold text-card-foreground">92/100</p>
                </div>
              </div>
            </div>

            {/* Related Skills */}
            <div>
              <p className="text-sm font-medium text-card-foreground mb-3">Related Skills</p>
              <div className="flex flex-wrap gap-2">
                <SkillBadge name="TypeScript" proficiency="advanced" size="sm" />
                <SkillBadge name="Node.js" proficiency="intermediate" size="sm" />
                <SkillBadge name="GraphQL" proficiency="beginner" size="sm" />
              </div>
            </div>

            {/* Learning Resources */}
            <div>
              <p className="text-sm font-medium text-card-foreground mb-3">Recommended Resources</p>
              <div className="space-y-2">
                {['Official Documentation', 'Complete Course', 'Practice Projects'].map((resource) => (
                  <div
                    key={resource}
                    className="p-3 rounded-lg bg-background hover:bg-accent/50 transition-colors cursor-pointer"
                  >
                    <p className="text-sm font-medium text-card-foreground">{resource}</p>
                    <p className="text-xs text-muted-foreground">Click to explore</p>
                  </div>
                ))}
              </div>
            </div>
          </div>

          {/* Actions */}
          <div className="p-6 border-t border-border space-y-2">
            <Button className="w-full" onClick={() => onStartQuiz(node.id)}>
              <Brain className="h-4 w-4 mr-2" />
              Take Skill Quiz
            </Button>
            <Button variant="outline" className="w-full" onClick={() => onAddToLearning(node.id)}>
              <BookOpen className="h-4 w-4 mr-2" />
              Add to Learning Path
            </Button>
          </div>
        </div>
      </motion.div>
    </AnimatePresence>
  );
}
