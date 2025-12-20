import { useCallback, useMemo } from 'react';
import {
  ReactFlow,
  Background,
  Controls,
  MiniMap,
  useNodesState,
  useEdgesState,
  Node,
  Edge,
  ConnectionMode,
} from '@xyflow/react';
import '@xyflow/react/dist/style.css';
import { SkillNode } from './SkillNode';
import type { SkillGraph } from '@/types/api';

interface SkillGraphCanvasProps {
  graphData: SkillGraph;
  onNodeSelect: (node: Node) => void;
  userId: string;
}

const nodeTypes = {
  skill: SkillNode,
};

export function SkillGraphCanvas({ graphData, onNodeSelect }: SkillGraphCanvasProps) {
  const initialNodes: Node[] = useMemo(() => 
    graphData.nodes.map((node) => ({
      id: node.id,
      type: 'skill',
      position: node.position,
      data: node.data,
    })),
    [graphData.nodes]
  );

  const initialEdges: Edge[] = useMemo(() =>
    graphData.edges.map((edge) => ({
      id: edge.id,
      source: edge.source,
      target: edge.target,
      style: { stroke: 'hsl(var(--primary))', strokeWidth: 2, opacity: 0.5 },
      animated: true,
    })),
    [graphData.edges]
  );

  const [nodes, setNodes, onNodesChange] = useNodesState(initialNodes);
  const [edges, setEdges, onEdgesChange] = useEdgesState(initialEdges);

  const onNodeClick = useCallback(
    (_event: React.MouseEvent, node: Node) => {
      onNodeSelect(node);
    },
    [onNodeSelect]
  );

  return (
    <div className="h-[400px] sm:h-[500px] md:h-[600px] lg:h-[700px] w-full rounded-lg border border-border bg-card overflow-hidden touch-none">
      <ReactFlow
        nodes={nodes}
        edges={edges}
        onNodesChange={onNodesChange}
        onEdgesChange={onEdgesChange}
        onNodeClick={onNodeClick}
        nodeTypes={nodeTypes}
        connectionMode={ConnectionMode.Loose}
        fitView
        attributionPosition="bottom-left"
        proOptions={{ hideAttribution: true }}
        minZoom={0.1}
        maxZoom={2}
      >
        <Background color="hsl(var(--border))" gap={20} />
        <Controls 
          className="[&_button]:bg-card [&_button]:border-border [&_button]:text-foreground [&_button:hover]:bg-accent [&_button:hover]:text-accent-foreground [&_button]:h-8 [&_button]:w-8 sm:[&_button]:h-10 sm:[&_button]:w-10" 
        />
        <MiniMap
          nodeColor={(node) => {
            const level = node.data?.level as number || 50;
            if (level >= 80) return 'hsl(var(--primary))';
            if (level >= 60) return 'hsl(var(--chart-1))';
            if (level >= 40) return 'hsl(var(--chart-3))';
            return 'hsl(var(--muted))';
          }}
          className="bg-card border-border !h-24 sm:!h-32 md:!h-40 !w-32 sm:!w-40 md:!w-48"
          pannable
          zoomable
        />
      </ReactFlow>
    </div>
  );
}
