import { useQuery } from '@tanstack/react-query';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { GapTable, PriorityMeter } from '@/components/gap';
import { ProgressRing } from '@/components/ui/progress-ring';
import { SkillBadge } from '@/components/ui/skill-badge';
import { Skeleton } from '@/components/ui/skeleton';
import { learningApi } from '@/api/learning';

export default function GapAnalysisPage() {
  const navigate = useNavigate();
  const { data, isLoading } = useQuery({
    queryKey: ['gapAnalysis', 'user_1'],
    queryFn: () => learningApi.getGapAnalysis('user_1'),
  });

  if (isLoading) return <Skeleton className="h-96 rounded-lg" />;
  if (!data) return null;

  return (
    <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-foreground">Gap Analysis</h1>
        <p className="text-muted-foreground">For role: {data.roleName}</p>
      </div>

      <div className="grid lg:grid-cols-3 gap-6">
        <div className="rounded-lg border border-border bg-card p-6 flex items-center gap-6">
          <ProgressRing value={data.overallReadiness} size={100} />
          <div>
            <p className="text-sm text-muted-foreground">Role Readiness</p>
            <p className="text-2xl font-bold text-card-foreground">{data.overallReadiness}%</p>
          </div>
        </div>
        
        <div className="rounded-lg border border-border bg-card p-6">
          <p className="text-sm font-medium text-muted-foreground mb-3">Your Strengths</p>
          <div className="flex flex-wrap gap-2">
            {data.strengths.map((s) => (
              <SkillBadge key={s.id} name={s.name} proficiency={s.proficiency} size="sm" />
            ))}
          </div>
        </div>

        <div className="rounded-lg border border-border bg-card p-6">
          <PriorityMeter value={data.gaps.length} max={10} label="Skills to Improve" />
        </div>
      </div>

      <GapTable
        gaps={data.gaps}
        onAddToLearning={(id) => navigate(`/learning?add=${id}`)}
        onStartQuiz={(id) => navigate(`/quizzes?skill=${id}`)}
      />
    </motion.div>
  );
}
