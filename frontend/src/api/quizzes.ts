import axiosInstance from './axiosInstance';
import type { QuizResponse, QuizSubmitRequest, QuizResultResponse } from '@/types/api';

// Mock quiz data
const mockQuiz: QuizResponse = {
  quizId: 'quiz_1',
  skillId: '1',
  skillName: 'React',
  timeLimit: 600,
  questions: [
    {
      id: 'q1',
      question: 'What is the purpose of React.memo()?',
      options: [
        'To create a new component',
        'To optimize performance by memoizing component renders',
        'To handle errors in components',
        'To manage component state',
      ],
      difficulty: 'medium',
    },
    {
      id: 'q2',
      question: 'Which hook is used for side effects in functional components?',
      options: ['useState', 'useEffect', 'useContext', 'useReducer'],
      difficulty: 'easy',
    },
    {
      id: 'q3',
      question: 'What is the virtual DOM in React?',
      options: [
        'A copy of the real DOM kept in memory',
        'A new type of HTML element',
        'A browser API',
        'A CSS framework',
      ],
      difficulty: 'easy',
    },
    {
      id: 'q4',
      question: 'What is the purpose of the useCallback hook?',
      options: [
        'To create callbacks that are called after render',
        'To memoize functions between renders',
        'To handle async operations',
        'To manage component lifecycle',
      ],
      difficulty: 'hard',
    },
    {
      id: 'q5',
      question: 'What is the correct way to update state that depends on previous state?',
      options: [
        'setState(newValue)',
        'setState(prev => prev + 1)',
        'state = newValue',
        'this.state = newValue',
      ],
      difficulty: 'medium',
    },
  ],
};

export const quizzesApi = {
  getQuiz: async (skillId: string, userId?: string): Promise<QuizResponse> => {
    try {
      const params = userId ? `?user_id=${userId}` : '';
      const response = await axiosInstance.get<QuizResponse>(`/api/quizzes/${skillId}${params}`);
      return response.data;
    } catch (error) {
      // Fallback to mock for development
      if (import.meta.env.DEV) {
        return new Promise((resolve) => {
          setTimeout(() => resolve({ ...mockQuiz, skillId }), 300);
        });
      }
      throw error;
    }
  },

  submitQuiz: async (submission: QuizSubmitRequest): Promise<QuizResultResponse> => {
    try {
      const response = await axiosInstance.post<QuizResultResponse>('/api/quiz-submit', submission);
      return response.data;
    } catch (error) {
      // Fallback to mock for development
      if (import.meta.env.DEV) {
        return new Promise((resolve) => {
      setTimeout(() => {
        const correctAnswers = [1, 1, 0, 1, 1];
        let score = 0;
        const feedback = submission.answers.map((answer, index) => {
          const isCorrect = answer.answer === correctAnswers[index];
          if (isCorrect) score++;
          return {
            questionId: answer.questionId,
            correct: isCorrect,
            correctAnswer: correctAnswers[index],
            explanation: isCorrect ? 'Correct!' : 'Review this concept in the documentation.',
          };
        });

        resolve({
          quizId: submission.quizId,
          score: Math.round((score / submission.answers.length) * 100),
          totalQuestions: submission.answers.length,
          correctAnswers: score,
          skillLevelChange: score >= 3 ? 5 : 0,
          feedback,
        });
      }, 500);
      });
      }
      throw error;
    }
  },

  getQuizHistory: async (userId: string): Promise<QuizResultResponse[]> => {
    const response = await axiosInstance.get<QuizResultResponse[]>(`/api/quiz-history/${userId}`);
    return response.data;
  },
};
