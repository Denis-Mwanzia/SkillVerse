import axiosInstance from './axiosInstance';
import type { WhatIfRequest, WhatIfResponse } from '@/types/api';

export const whatIfApi = {
  simulate: async (request: WhatIfRequest): Promise<WhatIfResponse> => {
    try {
      const response = await axiosInstance.post<WhatIfResponse>('/api/what-if', request);
      return response.data;
    } catch (error) {
      // Fallback to mock for development
      if (import.meta.env.DEV) {
        // Mock simulation response
        return new Promise((resolve) => {
      setTimeout(() => {
        const skillCount = request.scenario.skillsToLearn.length;
        const baseImprovement = skillCount * 8;
        
        resolve({
          currentState: {
            matchScore: 72,
            marketability: 68,
            salaryRange: { min: 120000, max: 150000 },
          },
          projectedState: {
            matchScore: Math.min(72 + baseImprovement, 95),
            marketability: Math.min(68 + baseImprovement + 5, 92),
            salaryRange: { min: 140000, max: 180000 },
          },
          newOpportunities: [
            {
              id: 'opp1',
              title: 'Staff Engineer',
              matchScore: 88,
              salary: { min: 180000, max: 250000, currency: 'USD' },
              requiredSkills: [...request.scenario.skillsToLearn, 'Leadership'],
              matchingSkills: request.scenario.skillsToLearn,
              missingSkills: ['Leadership'],
              growthPotential: 9,
            },
            {
              id: 'opp2',
              title: 'Engineering Manager',
              matchScore: 75,
              salary: { min: 170000, max: 230000, currency: 'USD' },
              requiredSkills: [...request.scenario.skillsToLearn, 'Team Management'],
              matchingSkills: request.scenario.skillsToLearn.slice(0, 2),
              missingSkills: ['Team Management'],
              growthPotential: 10,
            },
          ],
          requiredEffort: {
            totalHours: skillCount * 40,
            dailyCommitment: Math.ceil((skillCount * 40) / (request.scenario.timeframe * 30)),
          },
        });
      }, 800);
      });
      }
      throw error;
    }
  },
};
