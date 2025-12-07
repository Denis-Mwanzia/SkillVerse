import type { DashboardResponse } from '@/types/api';

const mockDashboard: DashboardResponse = {
  user: {
    id: 'user_1',
    email: 'demo@skillverse.ai',
    name: 'Denis Mwanzia',
    avatar: undefined,
    createdAt: '2024-01-15T00:00:00Z',
  },
  stats: {
    totalSkills: 10,
    skillGrowth: 15,
    completedCourses: 8,
    quizzesTaken: 24,
    averageScore: 82,
    streak: 7,
  },
  recentActivity: [
    { id: 'a1', type: 'quiz_completed', title: 'React Quiz Completed', description: 'Scored 85% on React fundamentals', timestamp: new Date(Date.now() - 3600000).toISOString() },
    { id: 'a2', type: 'skill_added', title: 'New Skill Added', description: 'GraphQL added to your skill graph', timestamp: new Date(Date.now() - 86400000).toISOString() },
    { id: 'a3', type: 'course_completed', title: 'Course Completed', description: 'Finished AWS Cloud Practitioner prep', timestamp: new Date(Date.now() - 172800000).toISOString() },
    { id: 'a4', type: 'milestone_reached', title: 'Milestone Reached', description: 'Reached advanced level in TypeScript', timestamp: new Date(Date.now() - 259200000).toISOString() },
  ],
  trendingSkills: [
    { id: 't1', skillName: 'AI/ML', trend: 'rising', demandScore: 95, growthRate: 45, jobCount: 15420, avgSalary: 165000, industries: ['Tech', 'Finance'] },
    { id: 't2', skillName: 'Rust', trend: 'rising', demandScore: 78, growthRate: 62, jobCount: 3240, avgSalary: 155000, industries: ['Tech'] },
    { id: 't3', skillName: 'Kubernetes', trend: 'rising', demandScore: 88, growthRate: 28, jobCount: 12500, avgSalary: 145000, industries: ['Tech', 'Finance'] },
  ],
  upcomingDeadlines: [
    { id: 'd1', title: 'AWS Certification Exam', dueDate: '2024-04-15', type: 'certification' },
    { id: 'd2', title: 'Complete Docker Course', dueDate: '2024-03-30', type: 'course' },
    { id: 'd3', title: 'Q2 Skill Goal Review', dueDate: '2024-04-01', type: 'goal' },
  ],
  recommendations: [
    {
      id: 'r1',
      title: 'Senior Full Stack Engineer',
      matchScore: 85,
      salary: { min: 150000, max: 200000, currency: 'USD' },
      requiredSkills: ['React', 'Node.js', 'TypeScript', 'AWS'],
      matchingSkills: ['React', 'Node.js', 'TypeScript'],
      missingSkills: ['AWS'],
      growthPotential: 8,
    },
  ],
};

export const dashboardApi = {
  getDashboard: async (userId: string): Promise<DashboardResponse> => {
    try {
      const response = await axiosInstance.get<DashboardResponse>(`/api/dashboard/${userId}`);
      return response.data;
    } catch (error) {
      // Fallback to mock for development
      if (import.meta.env.DEV) {
        return new Promise((resolve) => {
          setTimeout(() => resolve(mockDashboard), 300);
        });
      }
      throw error;
    }
  },
};
