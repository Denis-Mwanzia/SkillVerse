import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { motion } from 'framer-motion';
import { LearningTimeline } from '@/components/learning';
import { Skeleton } from '@/components/ui/skeleton';
import { learningApi } from '@/api/learning';

export default function LearningPathPage() {
  const queryClient = useQueryClient();
  const { data, isLoading } = useQuery({
    queryKey: ['learningPath', 'user_1'],
    queryFn: () => learningApi.getLearningPath('user_1'),
  });

  const toggleMutation = useMutation({
    mutationFn: ({ stepId, completed }: { stepId: string; completed: boolean }) =>
      learningApi.updateStepProgress(stepId, completed),
    onMutate: async ({ stepId, completed }) => {
      await queryClient.cancelQueries({ queryKey: ['learningPath', 'user_1'] });
      queryClient.setQueryData(['learningPath', 'user_1'], (old: typeof data) =>
        old ? { ...old, steps: old.steps.map((s) => (s.id === stepId ? { ...s, completed } : s)) } : old
      );
    },
  });

  if (isLoading) return <Skeleton className="h-96 rounded-lg" />;
  if (!data) return null;

  return (
    <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="space-y-6 max-w-4xl">
      <div>
        <h1 className="text-2xl font-bold text-foreground">Learning Path</h1>
        <p className="text-muted-foreground">Your personalized journey to {data.roleName}</p>
      </div>

      <LearningTimeline
        steps={data.steps}
        onToggleComplete={(stepId, completed) => toggleMutation.mutate({ stepId, completed })}
      />
    </motion.div>
  );
}
