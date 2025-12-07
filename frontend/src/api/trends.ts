import axiosInstance from './axiosInstance';
import type { TrendResponse, TrendSignal, RoleRecommendationsResponse } from '@/types/api';

const mockTrends: TrendResponse = {
  signals: [
    { id: 't1', skillName: 'AI/ML', trend: 'rising', demandScore: 95, growthRate: 45, jobCount: 15420, avgSalary: 165000, industries: ['Tech', 'Finance', 'Healthcare'] },
    { id: 't2', skillName: 'Rust', trend: 'rising', demandScore: 78, growthRate: 62, jobCount: 3240, avgSalary: 155000, industries: ['Tech', 'Blockchain'] },
    { id: 't3', skillName: 'Kubernetes', trend: 'rising', demandScore: 88, growthRate: 28, jobCount: 12500, avgSalary: 145000, industries: ['Tech', 'Finance', 'E-commerce'] },
    { id: 't4', skillName: 'React', trend: 'stable', demandScore: 92, growthRate: 5, jobCount: 45000, avgSalary: 135000, industries: ['Tech', 'Media', 'Retail'] },
    { id: 't5', skillName: 'Python', trend: 'stable', demandScore: 94, growthRate: 8, jobCount: 52000, avgSalary: 140000, industries: ['Tech', 'Finance', 'Research'] },
    { id: 't6', skillName: 'PHP', trend: 'declining', demandScore: 45, growthRate: -12, jobCount: 8500, avgSalary: 95000, industries: ['E-commerce', 'Media'] },
  ],
  topSkills: ['Python', 'AI/ML', 'React', 'Kubernetes', 'TypeScript'],
  emergingSkills: ['Rust', 'WebAssembly', 'Edge Computing', 'LLM Engineering'],
  lastUpdated: new Date().toISOString(),
};

const mockRoleRecommendations: RoleRecommendationsResponse = {
  recommendations: [
    {
      id: 'r1',
      title: 'Senior Full Stack Engineer',
      matchScore: 85,
      company: 'Tech Corp',
      salary: { min: 150000, max: 200000, currency: 'USD' },
      requiredSkills: ['React', 'Node.js', 'TypeScript', 'AWS', 'PostgreSQL'],
      matchingSkills: ['React', 'Node.js', 'TypeScript', 'PostgreSQL'],
      missingSkills: ['AWS'],
      growthPotential: 8,
    },
    {
      id: 'r2',
      title: 'Frontend Architect',
      matchScore: 78,
      salary: { min: 160000, max: 220000, currency: 'USD' },
      requiredSkills: ['React', 'TypeScript', 'GraphQL', 'Performance Optimization'],
      matchingSkills: ['React', 'TypeScript'],
      missingSkills: ['GraphQL', 'Performance Optimization'],
      growthPotential: 9,
    },
    {
      id: 'r3',
      title: 'ML Engineer',
      matchScore: 55,
      salary: { min: 140000, max: 190000, currency: 'USD' },
      requiredSkills: ['Python', 'TensorFlow', 'Machine Learning', 'AWS'],
      matchingSkills: ['Python'],
      missingSkills: ['TensorFlow', 'Machine Learning', 'AWS'],
      growthPotential: 10,
    },
  ],
  careerPaths: [
    { id: 'cp1', name: 'Engineering Leadership', roles: ['Senior Engineer', 'Staff Engineer', 'Engineering Manager', 'VP Engineering'], timeline: '5-8 years' },
    { id: 'cp2', name: 'Technical Specialist', roles: ['Senior Engineer', 'Principal Engineer', 'Distinguished Engineer'], timeline: '6-10 years' },
  ],
};

export const trendsApi = {
  getTrendSignals: async (): Promise<TrendResponse> => {
    try {
      const response = await axiosInstance.get<TrendResponse>('/api/trend-signals');
      return response.data;
    } catch (error) {
      // Fallback to mock for development
      if (import.meta.env.DEV) {
        return new Promise((resolve) => {
          setTimeout(() => resolve(mockTrends), 300);
        });
      }
      throw error;
    }
  },

  getRoleRecommendations: async (userId: string): Promise<RoleRecommendationsResponse> => {
    try {
      const response = await axiosInstance.get<RoleRecommendationsResponse>(`/api/role-recommendations/${userId}`);
      return response.data;
    } catch (error) {
      // Fallback to mock for development
      if (import.meta.env.DEV) {
        return new Promise((resolve) => {
          setTimeout(() => resolve(mockRoleRecommendations), 400);
        });
      }
      throw error;
    }
  },

  subscribeToTrend: async (skillName: string): Promise<void> => {
    await axiosInstance.post('/api/trends/subscribe', { skillName });
  },
};
