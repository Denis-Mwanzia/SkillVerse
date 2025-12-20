import axiosInstance from './axiosInstance';
import type { GapAnalysisResponse, LearningPathResponse, LearningStep } from '@/types/api';

// Mock data for demo
const mockGapAnalysis: GapAnalysisResponse = {
  roleId: 'role_1',
  roleName: 'Senior Full Stack Engineer',
  overallReadiness: 72,
  gaps: [
    { skillId: '5', skillName: 'AWS', currentLevel: 55, requiredLevel: 80, gap: 25, severity: 'high', importance: 9, learningTime: '40 hours' },
    { skillId: '9', skillName: 'Machine Learning', currentLevel: 40, requiredLevel: 60, gap: 20, severity: 'medium', importance: 7, learningTime: '60 hours' },
    { skillId: '7', skillName: 'GraphQL', currentLevel: 50, requiredLevel: 70, gap: 20, severity: 'medium', importance: 6, learningTime: '25 hours' },
    { skillId: '6', skillName: 'Docker', currentLevel: 60, requiredLevel: 75, gap: 15, severity: 'low', importance: 8, learningTime: '20 hours' },
  ],
  strengths: [
    { id: '1', name: 'React', level: 85, category: 'Frontend', proficiency: 'advanced', lastUpdated: new Date().toISOString() },
    { id: '2', name: 'TypeScript', level: 80, category: 'Languages', proficiency: 'advanced', lastUpdated: new Date().toISOString() },
    { id: '8', name: 'PostgreSQL', level: 75, category: 'Database', proficiency: 'advanced', lastUpdated: new Date().toISOString() },
  ],
};

const mockLearningPath: LearningPathResponse = {
  roleId: 'role_1',
  roleName: 'Senior Full Stack Engineer',
  totalDuration: '145 hours',
  estimatedCompletionDate: '2024-06-15',
  steps: [
    {
      id: 'step_1',
      title: 'AWS Cloud Practitioner Certification',
      description: 'Build foundational cloud skills with AWS certification course',
      skillId: '5',
      resourceType: 'certification',
      provider: 'AWS Training',
      duration: '40 hours',
      url: 'https://aws.amazon.com/training',
      completed: false,
      order: 1,
    },
    {
      id: 'step_2',
      title: 'Docker Fundamentals',
      description: 'Master containerization with hands-on Docker exercises',
      skillId: '6',
      resourceType: 'course',
      provider: 'Docker Official',
      duration: '20 hours',
      url: 'https://docker.com/learn',
      completed: false,
      order: 2,
    },
    {
      id: 'step_3',
      title: 'GraphQL Complete Guide',
      description: 'Learn to build and consume GraphQL APIs',
      skillId: '7',
      resourceType: 'course',
      provider: 'Udemy',
      duration: '25 hours',
      completed: true,
      order: 3,
    },
    {
      id: 'step_4',
      title: 'Machine Learning Fundamentals',
      description: 'Introduction to ML concepts and practical applications',
      skillId: '9',
      resourceType: 'course',
      provider: 'Coursera',
      duration: '60 hours',
      completed: false,
      order: 4,
    },
  ],
};

export const learningApi = {
  getGapAnalysis: async (userId: string, roleId?: string): Promise<GapAnalysisResponse> => {
    try {
      const params = roleId ? `?role_id=${roleId}` : '';
      const response = await axiosInstance.get<GapAnalysisResponse>(`/api/gap-analysis/${userId}${params}`);
      return response.data;
    } catch (error) {
      // Fallback to mock for development
      if (import.meta.env.DEV) {
        return new Promise((resolve) => {
          setTimeout(() => resolve(mockGapAnalysis), 400);
        });
      }
      throw error;
    }
  },

  getLearningPath: async (userId: string, roleId?: string): Promise<LearningPathResponse> => {
    try {
      const params = roleId ? `?role_id=${roleId}` : '';
      const response = await axiosInstance.get<LearningPathResponse>(`/api/learning-path/${userId}${params}`);
      return response.data;
    } catch (error) {
      // Fallback to mock for development
      if (import.meta.env.DEV) {
        return new Promise((resolve) => {
          setTimeout(() => resolve(mockLearningPath), 400);
        });
      }
      throw error;
    }
  },

  updateStepProgress: async (stepId: string, completed: boolean): Promise<LearningStep> => {
    const response = await axiosInstance.patch<LearningStep>(`/api/learning-steps/${stepId}`, { completed });
    return response.data;
  },

  addToLearningPath: async (userId: string, skillId: string): Promise<LearningStep[]> => {
    const response = await axiosInstance.post<LearningStep[]>(`/api/learning-path/${userId}/add`, { skillId });
    return response.data;
  },
};
