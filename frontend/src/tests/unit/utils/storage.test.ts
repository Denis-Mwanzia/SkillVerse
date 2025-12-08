import { describe, it, expect, beforeEach, vi } from 'vitest';
import { tokenStorage } from '@/utils/storage';

describe('TokenStorage', () => {
  beforeEach(() => {
    localStorage.clear();
  });

  describe('Token Management', () => {
    it('should set and get access token', () => {
      tokenStorage.setAccessToken('test-access-token');
      expect(tokenStorage.getAccessToken()).toBe('test-access-token');
    });

    it('should set and get refresh token', () => {
      tokenStorage.setRefreshToken('test-refresh-token');
      expect(tokenStorage.getRefreshToken()).toBe('test-refresh-token');
    });

    it('should set both tokens together', () => {
      tokenStorage.setTokens('access-token', 'refresh-token');
      expect(tokenStorage.getAccessToken()).toBe('access-token');
      expect(tokenStorage.getRefreshToken()).toBe('refresh-token');
    });

    it('should remove tokens', () => {
      tokenStorage.setTokens('access-token', 'refresh-token');
      tokenStorage.removeAccessToken();
      expect(tokenStorage.getAccessToken()).toBeNull();
      expect(tokenStorage.getRefreshToken()).toBe('refresh-token');
      
      tokenStorage.removeRefreshToken();
      expect(tokenStorage.getRefreshToken()).toBeNull();
    });

    it('should clear all tokens', () => {
      tokenStorage.setTokens('access-token', 'refresh-token');
      tokenStorage.clearTokens();
      expect(tokenStorage.getAccessToken()).toBeNull();
      expect(tokenStorage.getRefreshToken()).toBeNull();
    });

    it('should check if tokens exist', () => {
      expect(tokenStorage.hasTokens()).toBe(false);
      tokenStorage.setTokens('access-token', 'refresh-token');
      expect(tokenStorage.hasTokens()).toBe(true);
      tokenStorage.removeAccessToken();
      expect(tokenStorage.hasTokens()).toBe(false);
    });
  });

  describe('Error Handling', () => {
    it('should handle localStorage errors gracefully', () => {
      const consoleSpy = vi.spyOn(console, 'warn').mockImplementation(() => {});
      
      // Mock localStorage to throw error
      const originalSetItem = Storage.prototype.setItem;
      Storage.prototype.setItem = vi.fn(() => {
        throw new Error('QuotaExceededError');
      });

      const result = tokenStorage.setAccessToken('test');
      expect(result).toBe(false);
      expect(consoleSpy).toHaveBeenCalled();

      Storage.prototype.setItem = originalSetItem;
      consoleSpy.mockRestore();
    });
  });
});

