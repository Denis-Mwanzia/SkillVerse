import { useQuery } from '@tanstack/react-query';
import { QuizContainer } from '@/components/quiz/QuizContainer';
import { Skeleton } from '@/components/ui/skeleton';
import { quizzesApi } from '@/api/quizzes';

export default function QuizPage() {
  const { data, isLoading } = useQuery({
    queryKey: ['quiz', '1'],
    queryFn: () => quizzesApi.getQuiz('1', 'user_1'),
  });

  if (isLoading) return <Skeleton className="h-96 rounded-lg" />;
  if (!data) return null;

  return (
    <div className="max-w-2xl mx-auto">
      <QuizContainer
        skillName={data.skillName}
        questions={data.questions}
        onSubmit={(answers) => quizzesApi.submitQuiz({ quizId: data.quizId, userId: 'user_1', answers, timeTaken: 300 })}
      />
    </div>
  );
}
