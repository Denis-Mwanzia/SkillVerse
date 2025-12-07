import { useEffect } from 'react';
import { useAuthStore } from '@/store/uiStore';
import { authApi } from '@/api/auth';
import { toast } from '@/hooks/use-toast';

export function useAuth() {
  const { user, isAuthenticated, isLoading, setUser, setIsLoading, logout } = useAuthStore();

  useEffect(() => {
    const checkAuth = async () => {
      const token = localStorage.getItem('access_token');
      if (!token) {
        setIsLoading(false);
        return;
      }

      try {
        // For demo, just set a mock user
        setUser({
          id: 'user_1',
          email: 'demo@skillverse.ai',
          name: 'Alex Johnson',
        });
      } catch {
        logout();
      }
    };

    if (isLoading) {
      checkAuth();
    }
  }, [isLoading, setUser, setIsLoading, logout]);

  const login = async (email: string, password: string) => {
    try {
      const response = await authApi.login({ email, password });
      localStorage.setItem('access_token', response.access_token);
      localStorage.setItem('refresh_token', response.refresh_token);
      setUser(response.user);
      toast({ title: 'Welcome back!', description: `Logged in as ${response.user.email}` });
      return response.user;
    } catch (error) {
      toast({ title: 'Login failed', description: 'Please check your credentials', variant: 'destructive' });
      throw error;
    }
  };

  const handleLogout = () => {
    logout();
    toast({ title: 'Logged out', description: 'See you next time!' });
  };

  return {
    user,
    isAuthenticated,
    isLoading,
    login,
    logout: handleLogout,
  };
}
