import { z } from 'zod';

export const loginSchema = z.object({
  email: z.string().email('Please enter a valid email address'),
  password: z.string().min(8, 'Password must be at least 8 characters'),
});

export const registerSchema = z.object({
  name: z.string().min(2, 'Name must be at least 2 characters'),
  email: z.string().email('Please enter a valid email address'),
  password: z.string().min(8, 'Password must be at least 8 characters'),
  confirmPassword: z.string(),
}).refine((data) => data.password === data.confirmPassword, {
  message: "Passwords don't match",
  path: ['confirmPassword'],
});

export const skillSchema = z.object({
  name: z.string().min(1, 'Skill name is required'),
  level: z.number().min(0).max(100),
  category: z.string().min(1, 'Category is required'),
  proficiency: z.enum(['beginner', 'intermediate', 'advanced', 'expert']),
});

export const whatIfSchema = z.object({
  skillsToLearn: z.array(z.string()).min(1, 'Select at least one skill'),
  targetRole: z.string().optional(),
  timeframe: z.number().min(1, 'Timeframe must be at least 1 month').max(24, 'Timeframe cannot exceed 24 months'),
});

export const quizAnswerSchema = z.object({
  questionId: z.string(),
  answer: z.number().min(0).max(3),
});

export type LoginFormData = z.infer<typeof loginSchema>;
export type RegisterFormData = z.infer<typeof registerSchema>;
export type SkillFormData = z.infer<typeof skillSchema>;
export type WhatIfFormData = z.infer<typeof whatIfSchema>;
export type QuizAnswerData = z.infer<typeof quizAnswerSchema>;
