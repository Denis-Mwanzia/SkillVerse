import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Clock, ChevronRight } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { cn } from '@/lib/utils';
import type { QuizQuestion, QuizResultResponse } from '@/types/api';

interface QuizContainerProps {
  skillName: string;
  questions: QuizQuestion[];
  onSubmit: (answers: { questionId: string; answer: number }[]) => Promise<QuizResultResponse>;
}

export function QuizContainer({ skillName, questions, onSubmit }: QuizContainerProps) {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [answers, setAnswers] = useState<Record<string, number>>({});
  const [result, setResult] = useState<QuizResultResponse | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const currentQuestion = questions[currentIndex];
  const isLastQuestion = currentIndex === questions.length - 1;
  const progress = ((currentIndex + 1) / questions.length) * 100;

  const handleAnswer = (answerIndex: number) => {
    setAnswers((prev) => ({ ...prev, [currentQuestion.id]: answerIndex }));
  };

  const handleNext = async () => {
    if (isLastQuestion) {
      setIsSubmitting(true);
      const submissionAnswers = Object.entries(answers).map(([questionId, answer]) => ({ questionId, answer }));
      const res = await onSubmit(submissionAnswers);
      setResult(res);
      setIsSubmitting(false);
    } else {
      setCurrentIndex((prev) => prev + 1);
    }
  };

  if (result) {
    return (
      <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="text-center py-12">
        <div className={cn('text-6xl mb-4', result.score >= 70 ? 'text-primary' : 'text-chart-4')}>
          {result.score >= 70 ? '🎉' : '📚'}
        </div>
        <h2 className="text-2xl font-bold text-card-foreground">
          {result.score >= 70 ? 'Great Job!' : 'Keep Learning!'}
        </h2>
        <p className="text-4xl font-bold text-primary mt-4">{result.score}%</p>
        <p className="text-muted-foreground mt-2">
          {result.correctAnswers} of {result.totalQuestions} correct
        </p>
        {result.skillLevelChange > 0 && (
          <p className="text-primary mt-4">+{result.skillLevelChange}% skill level increase!</p>
        )}
      </motion.div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold text-card-foreground">{skillName} Quiz</h2>
        <span className="flex items-center gap-1 text-sm text-muted-foreground">
          <Clock className="h-4 w-4" /> Question {currentIndex + 1}/{questions.length}
        </span>
      </div>

      <div className="h-2 bg-muted rounded-full overflow-hidden">
        <motion.div className="h-full bg-primary" animate={{ width: `${progress}%` }} />
      </div>

      <AnimatePresence mode="wait">
        <motion.div
          key={currentQuestion.id}
          initial={{ opacity: 0, x: 20 }}
          animate={{ opacity: 1, x: 0 }}
          exit={{ opacity: 0, x: -20 }}
          className="rounded-lg border border-border bg-card p-6"
        >
          <p className="text-lg font-medium text-card-foreground mb-6">{currentQuestion.question}</p>
          <div className="space-y-3">
            {currentQuestion.options.map((option, idx) => (
              <button
                key={idx}
                onClick={() => handleAnswer(idx)}
                className={cn(
                  'w-full p-4 rounded-lg border text-left transition-all',
                  answers[currentQuestion.id] === idx
                    ? 'border-primary bg-primary/10 text-card-foreground'
                    : 'border-border bg-background hover:border-primary/50 text-muted-foreground'
                )}
              >
                {option}
              </button>
            ))}
          </div>
        </motion.div>
      </AnimatePresence>

      <div className="flex justify-end">
        <Button
          onClick={handleNext}
          disabled={answers[currentQuestion.id] === undefined || isSubmitting}
        >
          {isLastQuestion ? 'Submit Quiz' : 'Next'} <ChevronRight className="h-4 w-4 ml-1" />
        </Button>
      </div>
    </div>
  );
}
