// API Types for SkillVerse

export interface User {
  id: string;
  email: string;
  name: string;
  avatar?: string;
  createdAt: string;
  bio?: string;
  location?: string;
  website?: string;
  linkedin?: string;
  github?: string;
  verified?: boolean;
}

export interface AuthResponse {
  access_token: string;
  refresh_token: string;
  user: User;
}

export interface LoginRequest {
  email: string;
  password: string;
}

export interface Skill {
  id: string;
  name: string;
  level: number;
  category: string;
  proficiency: 'beginner' | 'intermediate' | 'advanced' | 'expert';
  lastUpdated: string;
  trending?: boolean;
  demand?: number;
}

export interface SkillNode {
  id: string;
  data: {
    label: string;
    level: number;
    category: string;
    proficiency: string;
  };
  position: { x: number; y: number };
  type?: string;
}

export interface SkillEdge {
  id: string;
  source: string;
  target: string;
  type?: string;
}

export interface SkillGraph {
  nodes: SkillNode[];
  edges: SkillEdge[];
  clusters: SkillCluster[];
}

export interface SkillCluster {
  id: string;
  name: string;
  skills: string[];
  color: string;
}

export interface ResumeUploadResponse {
  success: boolean;
  extractedSkills: Skill[];
  experience: ExperienceEntry[];
  education: EducationEntry[];
  recommendations: string[];
}

export interface ExperienceEntry {
  id: string;
  company: string;
  role: string;
  startDate: string;
  endDate?: string;
  skills: string[];
}

export interface EducationEntry {
  id: string;
  institution: string;
  degree: string;
  field: string;
  year: number;
}

export interface GapAnalysisItem {
  skillId: string;
  skillName: string;
  currentLevel: number;
  requiredLevel: number;
  gap: number;
  severity: 'low' | 'medium' | 'high' | 'critical';
  importance: number;
  learningTime: string;
}

export interface GapAnalysisResponse {
  roleId: string;
  roleName: string;
  overallReadiness: number;
  gaps: GapAnalysisItem[];
  strengths: Skill[];
}

export interface LearningStep {
  id: string;
  title: string;
  description: string;
  skillId: string;
  resourceType: 'course' | 'video' | 'article' | 'project' | 'certification';
  provider: string;
  duration: string;
  url?: string;
  completed: boolean;
  order: number;
}

export interface LearningPathResponse {
  roleId: string;
  roleName: string;
  totalDuration: string;
  steps: LearningStep[];
  estimatedCompletionDate: string;
}

export interface QuizQuestion {
  id: string;
  question: string;
  options: string[];
  correctAnswer?: number;
  explanation?: string;
  difficulty: 'easy' | 'medium' | 'hard';
}

export interface QuizResponse {
  quizId: string;
  skillId: string;
  skillName: string;
  questions: QuizQuestion[];
  timeLimit?: number;
}

export interface QuizSubmitRequest {
  quizId: string;
  userId: string;
  answers: { questionId: string; answer: number }[];
  timeTaken: number;
}

export interface QuizResultResponse {
  quizId: string;
  score: number;
  totalQuestions: number;
  correctAnswers: number;
  skillLevelChange: number;
  feedback: QuizFeedback[];
}

export interface QuizFeedback {
  questionId: string;
  correct: boolean;
  correctAnswer: number;
  explanation: string;
}

export interface TrendSignal {
  id: string;
  skillName: string;
  trend: 'rising' | 'stable' | 'declining';
  demandScore: number;
  growthRate: number;
  jobCount: number;
  avgSalary: number;
  industries: string[];
}

export interface TrendResponse {
  signals: TrendSignal[];
  topSkills: string[];
  emergingSkills: string[];
  lastUpdated: string;
}

export interface RoleRecommendation {
  id: string;
  title: string;
  matchScore: number;
  company?: string;
  salary: {
    min: number;
    max: number;
    currency: string;
  };
  requiredSkills: string[];
  matchingSkills: string[];
  missingSkills: string[];
  growthPotential: number;
}

export interface RoleRecommendationsResponse {
  recommendations: RoleRecommendation[];
  careerPaths: CareerPath[];
}

export interface CareerPath {
  id: string;
  name: string;
  roles: string[];
  timeline: string;
}

export interface WhatIfRequest {
  userId: string;
  scenario: {
    skillsToLearn: string[];
    targetRole?: string;
    timeframe: number;
  };
}

export interface WhatIfResponse {
  currentState: {
    matchScore: number;
    marketability: number;
    salaryRange: { min: number; max: number };
  };
  projectedState: {
    matchScore: number;
    marketability: number;
    salaryRange: { min: number; max: number };
  };
  newOpportunities: RoleRecommendation[];
  requiredEffort: {
    totalHours: number;
    dailyCommitment: number;
  };
}

export interface DashboardStats {
  totalSkills: number;
  skillGrowth: number;
  completedCourses: number;
  quizzesTaken: number;
  averageScore: number;
  streak: number;
}

export interface DashboardResponse {
  user: User;
  stats: DashboardStats;
  recentActivity: ActivityItem[];
  trendingSkills: TrendSignal[];
  upcomingDeadlines: Deadline[];
  recommendations: RoleRecommendation[];
}

export interface ActivityItem {
  id: string;
  type: 'skill_added' | 'quiz_completed' | 'course_completed' | 'milestone_reached';
  title: string;
  description: string;
  timestamp: string;
}

export interface Deadline {
  id: string;
  title: string;
  dueDate: string;
  type: 'course' | 'certification' | 'goal';
}

// Socket Events
export interface SocketEvents {
  skill_updated: { userId: string; skill: Skill };
  trend_alert: TrendSignal;
  quiz_completed: { userId: string; result: QuizResultResponse };
  learning_progress: { userId: string; stepId: string; completed: boolean };
}
