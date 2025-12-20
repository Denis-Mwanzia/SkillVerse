import axiosInstance from './axiosInstance';
import type { SkillGraph, ResumeUploadResponse, Skill } from '@/types/api';

// Mock data for demo
const mockSkillGraph: SkillGraph = {
  nodes: [
    { id: '1', data: { label: 'React', level: 85, category: 'Frontend', proficiency: 'advanced' }, position: { x: 250, y: 100 } },
    { id: '2', data: { label: 'TypeScript', level: 80, category: 'Languages', proficiency: 'advanced' }, position: { x: 400, y: 150 } },
    { id: '3', data: { label: 'Node.js', level: 70, category: 'Backend', proficiency: 'intermediate' }, position: { x: 100, y: 200 } },
    { id: '4', data: { label: 'Python', level: 65, category: 'Languages', proficiency: 'intermediate' }, position: { x: 300, y: 250 } },
    { id: '5', data: { label: 'AWS', level: 55, category: 'Cloud', proficiency: 'intermediate' }, position: { x: 450, y: 300 } },
    { id: '6', data: { label: 'Docker', level: 60, category: 'DevOps', proficiency: 'intermediate' }, position: { x: 150, y: 350 } },
    { id: '7', data: { label: 'GraphQL', level: 50, category: 'API', proficiency: 'beginner' }, position: { x: 350, y: 400 } },
    { id: '8', data: { label: 'PostgreSQL', level: 75, category: 'Database', proficiency: 'advanced' }, position: { x: 200, y: 450 } },
    { id: '9', data: { label: 'Machine Learning', level: 40, category: 'AI', proficiency: 'beginner' }, position: { x: 500, y: 200 } },
    { id: '10', data: { label: 'TensorFlow', level: 35, category: 'AI', proficiency: 'beginner' }, position: { x: 550, y: 350 } },
  ],
  edges: [
    { id: 'e1-2', source: '1', target: '2' },
    { id: 'e1-3', source: '1', target: '3' },
    { id: 'e2-4', source: '2', target: '4' },
    { id: 'e3-6', source: '3', target: '6' },
    { id: 'e4-9', source: '4', target: '9' },
    { id: 'e5-6', source: '5', target: '6' },
    { id: 'e7-1', source: '7', target: '1' },
    { id: 'e8-3', source: '8', target: '3' },
    { id: 'e9-10', source: '9', target: '10' },
  ],
  clusters: [
    { id: 'c1', name: 'Frontend', skills: ['1', '2', '7'], color: '#3b82f6' },
    { id: 'c2', name: 'Backend', skills: ['3', '8'], color: '#10b981' },
    { id: 'c3', name: 'AI/ML', skills: ['9', '10'], color: '#8b5cf6' },
    { id: 'c4', name: 'DevOps', skills: ['5', '6'], color: '#f59e0b' },
  ],
};

export const skillsApi = {
  getSkillGraph: async (userId: string): Promise<SkillGraph> => {
    try {
      const response = await axiosInstance.get<SkillGraph>(`/api/skill-graph/${userId}`);
      return response.data;
    } catch (error) {
      // Fallback to mock for development
      if (import.meta.env.DEV) {
        return new Promise((resolve) => {
          setTimeout(() => resolve(mockSkillGraph), 300);
        });
      }
      throw error;
    }
  },

  uploadResume: async (file: File): Promise<ResumeUploadResponse> => {
    try {
      const formData = new FormData();
      formData.append('file', file);
      const response = await axiosInstance.post<ResumeUploadResponse>('/api/upload-resume', formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });
      return response.data;
    } catch (error) {
      // Fallback to mock for development
      if (import.meta.env.DEV) {
        // Mock response for demo
        return new Promise((resolve) => {
      setTimeout(() => {
        resolve({
          success: true,
          extractedSkills: [
            { id: '1', name: 'React', level: 85, category: 'Frontend', proficiency: 'advanced', lastUpdated: new Date().toISOString() },
            { id: '2', name: 'TypeScript', level: 80, category: 'Languages', proficiency: 'advanced', lastUpdated: new Date().toISOString() },
            { id: '3', name: 'Node.js', level: 70, category: 'Backend', proficiency: 'intermediate', lastUpdated: new Date().toISOString() },
          ],
          experience: [
            { id: 'exp1', company: 'Tech Corp', role: 'Senior Developer', startDate: '2021-01', skills: ['React', 'TypeScript'] },
            { id: 'exp2', company: 'Startup Inc', role: 'Full Stack Developer', startDate: '2019-06', endDate: '2020-12', skills: ['Node.js', 'React'] },
          ],
          education: [
            { id: 'edu1', institution: 'State University', degree: 'Bachelor', field: 'Computer Science', year: 2019 },
          ],
          recommendations: [
            'Consider adding more cloud computing skills',
            'Your frontend skills are strong - consider exploring backend technologies',
          ],
        });
      }, 1500);
      });
      }
      throw error;
    }
  },

  addSkill: async (skill: Omit<Skill, 'id' | 'lastUpdated'>): Promise<Skill> => {
    const response = await axiosInstance.post<Skill>('/api/skills', skill);
    return response.data;
  },

  updateSkill: async (skillId: string, updates: Partial<Skill>): Promise<Skill> => {
    const response = await axiosInstance.patch<Skill>(`/api/skills/${skillId}`, updates);
    return response.data;
  },
};
