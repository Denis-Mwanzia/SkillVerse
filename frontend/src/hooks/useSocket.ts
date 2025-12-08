import { useEffect, useRef, useCallback } from 'react';
import { io, Socket } from 'socket.io-client';
import { useQueryClient } from '@tanstack/react-query';
import { toast } from '@/hooks/use-toast';
import { env } from '@/utils/env';
import { logger } from '@/utils/logger';

const SOCKET_URL = env.VITE_SOCKET_URL;

export function useSocket(userId?: string) {
  const socketRef = useRef<Socket | null>(null);
  const queryClient = useQueryClient();

  useEffect(() => {
    if (!userId) return;

    const socket = io(SOCKET_URL, {
      auth: { userId },
      transports: ['websocket'],
      reconnection: true,
      reconnectionAttempts: 5,
      reconnectionDelay: 1000,
    });

    socket.on('connect', () => {
      logger.info('Socket connected', { userId });
    });

    socket.on('skill_updated', (data) => {
      queryClient.invalidateQueries({ queryKey: ['skillGraph', userId] });
      toast({
        title: 'Skill Updated',
        description: `${data.skill.name} has been updated`,
      });
    });

    socket.on('trend_alert', (data) => {
      queryClient.invalidateQueries({ queryKey: ['trends'] });
      toast({
        title: 'Trend Alert',
        description: `${data.skillName} is ${data.trend}!`,
      });
    });

    socket.on('quiz_completed', (data) => {
      queryClient.invalidateQueries({ queryKey: ['dashboard', userId] });
    });

    socket.on('learning_progress', (data) => {
      queryClient.invalidateQueries({ queryKey: ['learningPath', userId] });
    });

    socket.on('disconnect', () => {
      logger.info('Socket disconnected', { userId });
    });

    socketRef.current = socket;

    return () => {
      socket.disconnect();
    };
  }, [userId, queryClient]);

  const emit = useCallback((event: string, data: unknown) => {
    if (socketRef.current?.connected) {
      socketRef.current.emit(event, data);
    }
  }, []);

  return { socket: socketRef.current, emit };
}
