import { describe, it, expect } from 'vitest';
import { render, screen, waitFor } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import Dashboard from '@/pages/Dashboard';
import { server } from '../../mocks/server';

const queryClient = new QueryClient({
  defaultOptions: {
    queries: { retry: false },
  },
});

const wrapper = ({ children }: { children: React.ReactNode }) => (
  <QueryClientProvider client={queryClient}>{children}</QueryClientProvider>
);

describe('Dashboard', () => {
  it('renders loading state', () => {
    render(<Dashboard />, { wrapper });
    expect(screen.getByText(/Welcome back/i)).toBeInTheDocument();
  });

  it('renders dashboard data after loading', async () => {
    render(<Dashboard />, { wrapper });
    await waitFor(() => {
      expect(screen.getByText(/Alex Johnson/i)).toBeInTheDocument();
    });
  });
});

