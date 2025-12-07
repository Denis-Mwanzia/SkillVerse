import { memo } from 'react';
import { Handle, Position, NodeProps } from '@xyflow/react';
import { cn } from '@/lib/utils';

interface SkillNodeData {
  label: string;
  level: number;
  category: string;
  proficiency: string;
}

export const SkillNode = memo(({ data, selected }: NodeProps) => {
  const nodeData = data as unknown as SkillNodeData;
  const level = nodeData.level || 50;
  
  const getNodeColor = () => {
    if (level >= 80) return 'border-primary bg-primary/10';
    if (level >= 60) return 'border-chart-1 bg-chart-1/10';
    if (level >= 40) return 'border-chart-3 bg-chart-3/10';
    return 'border-muted bg-muted/10';
  };

  return (
    <div
      className={cn(
        'px-4 py-3 rounded-lg border-2 transition-all cursor-pointer',
        getNodeColor(),
        selected && 'ring-2 ring-primary ring-offset-2 ring-offset-background'
      )}
    >
      <Handle type="target" position={Position.Top} className="!bg-primary !w-2 !h-2" />
      <div className="text-center min-w-[80px]">
        <p className="font-medium text-sm text-card-foreground">{nodeData.label}</p>
        <p className="text-xs text-muted-foreground mt-0.5">{level}%</p>
        <div className="mt-1 h-1 w-full bg-muted rounded-full overflow-hidden">
          <div
            className="h-full bg-primary transition-all"
            style={{ width: `${level}%` }}
          />
        </div>
      </div>
      <Handle type="source" position={Position.Bottom} className="!bg-primary !w-2 !h-2" />
    </div>
  );
});

SkillNode.displayName = 'SkillNode';
