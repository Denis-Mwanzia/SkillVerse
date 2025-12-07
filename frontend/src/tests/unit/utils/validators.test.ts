import { describe, it, expect } from 'vitest';
import { loginSchema, registerSchema, whatIfSchema, skillSchema } from '@/utils/validators';

describe('Zod Validators', () => {
  describe('loginSchema', () => {
    it('validates correct email and password', () => {
      const result = loginSchema.safeParse({
        email: 'test@example.com',
        password: 'password123',
      });
      expect(result.success).toBe(true);
    });

    it('rejects invalid email', () => {
      const result = loginSchema.safeParse({
        email: 'invalid-email',
        password: 'password123',
      });
      expect(result.success).toBe(false);
    });

    it('rejects short password', () => {
      const result = loginSchema.safeParse({
        email: 'test@example.com',
        password: 'short',
      });
      expect(result.success).toBe(false);
    });
  });

  describe('whatIfSchema', () => {
    it('validates correct data', () => {
      const result = whatIfSchema.safeParse({
        skillsToLearn: ['React', 'TypeScript'],
        timeframe: 3,
      });
      expect(result.success).toBe(true);
    });

    it('rejects empty skills array', () => {
      const result = whatIfSchema.safeParse({
        skillsToLearn: [],
        timeframe: 3,
      });
      expect(result.success).toBe(false);
    });

    it('rejects timeframe out of range', () => {
      const result = whatIfSchema.safeParse({
        skillsToLearn: ['React'],
        timeframe: 30,
      });
      expect(result.success).toBe(false);
    });
  });

  describe('skillSchema', () => {
    it('validates correct skill data', () => {
      const result = skillSchema.safeParse({
        name: 'React',
        level: 85,
        category: 'Frontend',
        proficiency: 'advanced',
      });
      expect(result.success).toBe(true);
    });

    it('rejects invalid proficiency', () => {
      const result = skillSchema.safeParse({
        name: 'React',
        level: 85,
        category: 'Frontend',
        proficiency: 'expert-level',
      });
      expect(result.success).toBe(false);
    });
  });
});

