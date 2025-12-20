import { useState } from 'react';
import { motion } from 'framer-motion';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { Sparkles, TrendingUp, DollarSign, Clock } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { SkillBadge } from '@/components/ui/skill-badge';
import { Form, FormControl, FormDescription, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form';
import { whatIfSchema, type WhatIfFormData } from '@/utils/validators';
import type { WhatIfResponse } from '@/types/api';
import { cn } from '@/lib/utils';

interface WhatIfFormProps {
  onSimulate: (skills: string[], timeframe: number) => Promise<WhatIfResponse>;
}

const availableSkills = ['AWS', 'Kubernetes', 'Machine Learning', 'GraphQL', 'Rust', 'Go', 'Docker'];

export function WhatIfForm({ onSimulate }: WhatIfFormProps) {
  const [result, setResult] = useState<WhatIfResponse | null>(null);
  const [isLoading, setIsLoading] = useState(false);

  const form = useForm<WhatIfFormData>({
    resolver: zodResolver(whatIfSchema),
    defaultValues: {
      skillsToLearn: [],
      targetRole: '',
      timeframe: 3,
    },
  });

  const selectedSkills = form.watch('skillsToLearn');

  const toggleSkill = (skill: string) => {
    const current = form.getValues('skillsToLearn');
    const updated = current.includes(skill)
      ? current.filter((s) => s !== skill)
      : [...current, skill];
    form.setValue('skillsToLearn', updated);
  };

  const handleSimulate = async (data: WhatIfFormData) => {
    setIsLoading(true);
    try {
      const res = await onSimulate(data.skillsToLearn, data.timeframe);
      setResult(res);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(handleSimulate)} className="grid lg:grid-cols-2 gap-4 sm:gap-6 lg:gap-8">
        <div className="space-y-4 sm:space-y-6">
          <FormField
            control={form.control}
            name="skillsToLearn"
            render={() => (
              <FormItem>
                <FormLabel className="text-base sm:text-lg text-card-foreground">Skills to Learn</FormLabel>
                <FormDescription className="text-xs sm:text-sm text-muted-foreground">
                  Select skills you want to add
                </FormDescription>
                <FormControl>
                  <div className="flex flex-wrap gap-2 sm:gap-3">
                    {availableSkills.map((skill) => (
                      <button
                        key={skill}
                        type="button"
                        onClick={() => toggleSkill(skill)}
                        aria-label={`Toggle ${skill}`}
                        className="touch-manipulation"
                      >
                        <SkillBadge
                          name={skill}
                          proficiency={selectedSkills.includes(skill) ? 'advanced' : 'beginner'}
                          className={cn(
                            selectedSkills.includes(skill) ? 'ring-2 ring-primary' : '',
                            'transition-all active:scale-95'
                          )}
                        />
                      </button>
                    ))}
                  </div>
                </FormControl>
                {selectedSkills.length > 0 && (
                  <div className="mt-2 text-xs sm:text-sm text-muted-foreground">
                    {selectedSkills.length} skill{selectedSkills.length !== 1 ? 's' : ''} selected
                  </div>
                )}
                <FormMessage />
              </FormItem>
            )}
          />

          <FormField
            control={form.control}
            name="timeframe"
            render={({ field }) => (
              <FormItem>
                <FormLabel htmlFor="timeframe" className="text-base sm:text-lg text-card-foreground">
                  Timeframe (months)
                </FormLabel>
                <FormControl>
                  <Input
                    id="timeframe"
                    type="number"
                    min={1}
                    max={24}
                    {...field}
                    onChange={(e) => field.onChange(Number(e.target.value))}
                    className="text-base sm:text-lg h-11 sm:h-12"
                  />
                </FormControl>
                <FormDescription className="text-xs sm:text-sm">
                  How long do you plan to learn these skills?
                </FormDescription>
                <FormMessage />
              </FormItem>
            )}
          />

          <Button 
            type="submit" 
            disabled={selectedSkills.length === 0 || isLoading} 
            className="w-full h-11 sm:h-12 text-base sm:text-lg font-semibold"
          >
            <Sparkles className="h-4 w-4 sm:h-5 sm:w-5 mr-2" />
            {isLoading ? 'Simulating...' : 'Run Simulation'}
          </Button>
        </div>

        {result && (
          <motion.div 
            initial={{ opacity: 0, y: 20 }} 
            animate={{ opacity: 1, y: 0 }} 
            className="space-y-3 sm:space-y-4 mt-4 lg:mt-0"
          >
            <h3 className="text-base sm:text-lg font-semibold text-card-foreground">Simulation Results</h3>
            
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 sm:gap-4">
              <div className="p-3 sm:p-4 rounded-lg border border-border bg-card hover:shadow-md transition-shadow">
                <TrendingUp className="h-4 w-4 sm:h-5 sm:w-5 text-primary mb-2" />
                <p className="text-xs sm:text-sm text-muted-foreground mb-1">Match Score</p>
                <p className="text-xl sm:text-2xl font-bold text-card-foreground leading-tight">
                  <span className="block sm:inline">{result.currentState.matchScore}%</span>
                  <span className="mx-1 sm:mx-2">→</span>
                  <span className="text-primary block sm:inline">{result.projectedState.matchScore}%</span>
                </p>
              </div>
              
              <div className="p-3 sm:p-4 rounded-lg border border-border bg-card hover:shadow-md transition-shadow">
                <DollarSign className="h-4 w-4 sm:h-5 sm:w-5 text-primary mb-2" />
                <p className="text-xs sm:text-sm text-muted-foreground mb-1">Salary Range</p>
                <p className="text-base sm:text-lg font-bold text-primary leading-tight">
                  ${(result.projectedState.salaryRange.min / 1000).toFixed(0)}K - ${(result.projectedState.salaryRange.max / 1000).toFixed(0)}K
                </p>
              </div>
              
              <div className="p-3 sm:p-4 rounded-lg border border-border bg-card hover:shadow-md transition-shadow col-span-1 sm:col-span-2">
                <Clock className="h-4 w-4 sm:h-5 sm:w-5 text-primary mb-2" />
                <p className="text-xs sm:text-sm text-muted-foreground mb-1">Required Effort</p>
                <p className="text-sm sm:text-base font-bold text-card-foreground leading-tight">
                  <span className="block sm:inline">{result.requiredEffort.totalHours} hours total</span>
                  <span className="hidden sm:inline mx-2">•</span>
                  <span className="block sm:inline">{result.requiredEffort.dailyCommitment}h/day</span>
                </p>
              </div>
            </div>
          </motion.div>
        )}
      </form>
    </Form>
  );
}
