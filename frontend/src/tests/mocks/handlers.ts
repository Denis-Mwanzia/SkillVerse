import { http, HttpResponse } from 'msw';
import type { 
  DashboardResponse, 
  SkillGraph, 
  GapAnalysisResponse,
  LearningPathResponse,
  QuizResponse,
  QuizResultResponse,
  TrendResponse,
  WhatIfResponse,
  RoleRecommendationsResponse,
  ResumeUploadResponse,
  AuthResponse,
} from '@/types/api';

const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000';

// Mock data
const mockDashboard: DashboardResponse = {
  user: {
    id: 'user_1',
    email: 'demo@skillverse.ai',
    name: 'Alex Johnson',
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
  ],
  trendingSkills: [
    { id: 't1', skillName: 'AI/ML', trend: 'rising', demandScore: 95, growthRate: 45, jobCount: 15420, avgSalary: 165000, industries: ['Tech', 'Finance'] },
  ],
  upcomingDeadlines: [
    { id: 'd1', title: 'AWS Certification Exam', dueDate: '2024-04-15', type: 'certification' },
  ],
  recommendations: [],
};

const mockSkillGraph: SkillGraph = {
  nodes: [
    { id: '1', data: { label: 'React', level: 85, category: 'Frontend', proficiency: 'advanced' }, position: { x: 250, y: 100 } },
    { id: '2', data: { label: 'TypeScript', level: 80, category: 'Languages', proficiency: 'advanced' }, position: { x: 400, y: 150 } },
  ],
  edges: [
    { id: 'e1-2', source: '1', target: '2' },
  ],
  clusters: [],
};

export const handlers = [
  // Auth endpoints
  http.post(`${API_BASE_URL}/api/auth/login`, async ({ request }) => {
    const body = await request.json() as { email: string; password: string };
    const response: AuthResponse = {
      access_token: 'mock_access_token',
      refresh_token: 'mock_refresh_token',
      user: {
        id: 'user_1',
        email: body.email,
        name: 'Demo User',
        createdAt: new Date().toISOString(),
      },
    };
    return HttpResponse.json(response);
  }),

  http.get(`${API_BASE_URL}/api/auth/profile`, () => {
    return HttpResponse.json({
      id: 'user_1',
      email: 'demo@skillverse.ai',
      name: 'Demo User',
      createdAt: '2024-01-15T00:00:00Z',
    });
  }),

  // Dashboard
  http.get(`${API_BASE_URL}/api/dashboard/:userId`, () => {
    return HttpResponse.json(mockDashboard);
  }),

  // Skill Graph
  http.get(`${API_BASE_URL}/api/skill-graph/:userId`, () => {
    return HttpResponse.json(mockSkillGraph);
  }),

  // Resume Upload
  http.post(`${API_BASE_URL}/api/upload-resume`, async () => {
    const response: ResumeUploadResponse = {
      success: true,
      extractedSkills: [
        { id: '1', name: 'React', level: 85, category: 'Frontend', proficiency: 'advanced', lastUpdated: new Date().toISOString() },
      ],
      experience: [],
      education: [],
      recommendations: [],
    };
    return HttpResponse.json(response);
  }),

  // Gap Analysis
  http.get(`${API_BASE_URL}/api/gap-analysis/:userId`, ({ request }) => {
    const url = new URL(request.url);
    const roleId = url.searchParams.get('role_id');
    const response: GapAnalysisResponse = {
      roleId: roleId || 'role_1',
      roleName: 'Senior Full Stack Engineer',
      overallReadiness: 72,
      gaps: [
        { skillId: '5', skillName: 'AWS', currentLevel: 55, requiredLevel: 80, gap: 25, severity: 'high', importance: 9, learningTime: '40 hours' },
      ],
      strengths: [],
    };
    return HttpResponse.json(response);
  }),

  // Learning Path
  http.get(`${API_BASE_URL}/api/learning-path/:userId`, ({ request }) => {
    const url = new URL(request.url);
    const roleId = url.searchParams.get('role_id');
    const response: LearningPathResponse = {
      roleId: roleId || 'role_1',
      roleName: 'Senior Full Stack Engineer',
      totalDuration: '145 hours',
      estimatedCompletionDate: '2024-06-15',
      steps: [
        {
          id: 'step_1',
          title: 'AWS Cloud Practitioner',
          description: 'Build foundational cloud skills',
          skillId: '5',
          resourceType: 'certification',
          provider: 'AWS Training',
          duration: '40 hours',
          url: 'https://aws.amazon.com/training',
          completed: false,
          order: 1,
        },
      ],
    };
    return HttpResponse.json(response);
  }),

  // Quizzes
  http.get(`${API_BASE_URL}/api/quizzes/:skillId`, ({ params }) => {
    const response: QuizResponse = {
      quizId: 'quiz_1',
      skillId: params.skillId as string,
      skillName: 'React',
      questions: [
        {
          id: 'q1',
          question: 'What is React?',
          options: ['A library', 'A framework', 'A language', 'A database'],
          difficulty: 'easy',
        },
      ],
    };
    return HttpResponse.json(response);
  }),

  http.post(`${API_BASE_URL}/api/quiz-submit`, async () => {
    const response: QuizResultResponse = {
      quizId: 'quiz_1',
      score: 85,
      totalQuestions: 5,
      correctAnswers: 4,
      skillLevelChange: 5,
      feedback: [],
    };
    return HttpResponse.json(response);
  }),

  // Trends
  http.get(`${API_BASE_URL}/api/trend-signals`, () => {
    const response: TrendResponse = {
      signals: [
        { id: 't1', skillName: 'AI/ML', trend: 'rising', demandScore: 95, growthRate: 45, jobCount: 15420, avgSalary: 165000, industries: ['Tech'] },
      ],
      topSkills: ['React', 'TypeScript'],
      emergingSkills: ['AI/ML'],
      lastUpdated: new Date().toISOString(),
    };
    return HttpResponse.json(response);
  }),

  // Role Recommendations
  http.get(`${API_BASE_URL}/api/role-recommendations/:userId`, () => {
    const response: RoleRecommendationsResponse = {
      recommendations: [
        {
          id: 'r1',
          title: 'Senior Full Stack Engineer',
          matchScore: 85,
          salary: { min: 150000, max: 200000, currency: 'USD' },
          requiredSkills: ['React', 'Node.js'],
          matchingSkills: ['React'],
          missingSkills: ['Node.js'],
          growthPotential: 8,
        },
      ],
      careerPaths: [],
    };
    return HttpResponse.json(response);
  }),

  // What-If
  http.post(`${API_BASE_URL}/api/what-if`, async () => {
    const response: WhatIfResponse = {
      currentState: {
        matchScore: 70,
        marketability: 65,
        salaryRange: { min: 120000, max: 150000 },
      },
      projectedState: {
        matchScore: 85,
        marketability: 80,
        salaryRange: { min: 150000, max: 200000 },
      },
      newOpportunities: [],
      requiredEffort: {
        totalHours: 120,
        dailyCommitment: 2,
      },
    };
    return HttpResponse.json(response);
  }),
];

