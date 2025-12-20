import { describe, it, expect, beforeEach, afterEach, vi } from 'vitest';
import { renderHook, act } from '@testing-library/react';
import { useDebounce, useThrottle } from '@/hooks/usePerformance';

describe('Performance Hooks', () => {
  beforeEach(() => {
    vi.useFakeTimers();
  });

  afterEach(() => {
    vi.restoreAllMocks();
    vi.useRealTimers();
  });

  describe('useDebounce', () => {
    it('should debounce function calls', () => {
      const mockFn = vi.fn();
      const { result } = renderHook(() => useDebounce(mockFn, 300));

      act(() => {
        result.current();
        result.current();
        result.current();
      });

      expect(mockFn).not.toHaveBeenCalled();

      act(() => {
        vi.advanceTimersByTime(300);
      });

      expect(mockFn).toHaveBeenCalledTimes(1);
    });

    it('should reset timer on subsequent calls', () => {
      const mockFn = vi.fn();
      const { result } = renderHook(() => useDebounce(mockFn, 300));

      act(() => {
        result.current();
        vi.advanceTimersByTime(200);
        result.current();
        vi.advanceTimersByTime(200);
      });

      expect(mockFn).not.toHaveBeenCalled();

      act(() => {
        vi.advanceTimersByTime(300);
      });

      expect(mockFn).toHaveBeenCalledTimes(1);
    });
  });

  describe('useThrottle', () => {
    it('should throttle function calls', () => {
      const mockFn = vi.fn();
      const { result } = renderHook(() => useThrottle(mockFn, 300));

      act(() => {
        result.current();
        result.current();
        result.current();
      });

      expect(mockFn).toHaveBeenCalledTimes(1);

      act(() => {
        vi.advanceTimersByTime(300);
      });

      expect(mockFn).toHaveBeenCalledTimes(2);
    });
  });
});

