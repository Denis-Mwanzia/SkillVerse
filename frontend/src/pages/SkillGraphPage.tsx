import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import { SkillGraphCanvas, NodeDetailsDrawer } from '@/components/graph';
import { Skeleton } from '@/components/ui/skeleton';
import { skillsApi } from '@/api/skills';
import { useNavigate } from 'react-router-dom';
import type { Node } from '@xyflow/react';

export default function SkillGraphPage() {
  const [selectedNode, setSelectedNode] = useState<Node | null>(null);
  const navigate = useNavigate();

  const { data, isLoading } = useQuery({
    queryKey: ['skillGraph', 'user_1'],
    queryFn: () => skillsApi.getSkillGraph('user_1'),
  });

  if (isLoading) return <Skeleton className="h-[600px] rounded-lg" />;
  if (!data) return null;

  return (
    <div className="space-y-4">
      <div>
        <h1 className="text-2xl font-bold text-foreground">Skill Graph</h1>
        <p className="text-muted-foreground">Visualize your skills and their connections</p>
      </div>
      
      <div className="h-[calc(100vh-200px)]">
        <SkillGraphCanvas graphData={data} onNodeSelect={setSelectedNode} userId="user_1" />
      </div>

      <NodeDetailsDrawer
        node={selectedNode}
        onClose={() => setSelectedNode(null)}
        onStartQuiz={(id) => navigate(`/quizzes?skill=${id}`)}
        onAddToLearning={(id) => navigate(`/learning?add=${id}`)}
      />
    </div>
  );
}
