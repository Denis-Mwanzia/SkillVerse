import { describe, it, expect, vi } from 'vitest';
import { renderHook, act } from '@testing-library/react';
import { useErrorHandler } from '@/hooks/useErrorHandler';
import { AxiosError } from 'axios';
import * as toastModule from '@/hooks/use-toast';

// Mock the toast hook
vi.mock('@/hooks/use-toast', () => ({
  toast: vi.fn(),
}));

// Mock logger
vi.mock('@/utils/logger', () => ({
  logger: {
    error: vi.fn(),
  },
}));

describe('useErrorHandler', () => {
  it('should handle AxiosError with response', () => {
    const { result } = renderHook(() => useErrorHandler());
    const mockError = {
      response: {
        status: 404,
        data: { message: 'Not found' },
      },
    } as unknown as AxiosError;

    act(() => {
      result.current.handleError(mockError);
    });

    expect(toastModule.toast).toHaveBeenCalledWith(
      expect.objectContaining({
        title: 'Error 404',
        variant: 'destructive',
      })
    );
  });

  it('should handle AxiosError with request but no response', () => {
    const { result } = renderHook(() => useErrorHandler());
    const mockError = {
      request: {},
      message: 'Network error',
    } as unknown as AxiosError;

    act(() => {
      result.current.handleError(mockError);
    });

    expect(toastModule.toast).toHaveBeenCalledWith(
      expect.objectContaining({
        title: 'Connection Error',
        variant: 'destructive',
      })
    );
  });

  it('should handle generic Error', () => {
    const { result } = renderHook(() => useErrorHandler());
    const error = new Error('Something went wrong');

    act(() => {
      result.current.handleError(error);
    });

    expect(toastModule.toast).toHaveBeenCalledWith(
      expect.objectContaining({
        title: 'Error',
        description: 'Something went wrong',
        variant: 'destructive',
      })
    );
  });

  it('should handle errors without showing toast when showToast is false', () => {
    const { result } = renderHook(() => useErrorHandler());
    const error = new Error('Test error');

    act(() => {
      result.current.handleError(error, { showToast: false });
    });

    expect(toastModule.toast).not.toHaveBeenCalled();
  });

  it('should return error message and title', () => {
    const { result } = renderHook(() => useErrorHandler());
    const error = new Error('Test error');

    let errorInfo;
    act(() => {
      errorInfo = result.current.handleError(error);
    });

    expect(errorInfo).toEqual({
      message: 'Test error',
      title: 'Error',
    });
  });
});

