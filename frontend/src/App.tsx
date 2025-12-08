import { Suspense, lazy } from 'react';
import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { ReactQueryDevtools } from '@tanstack/react-query-devtools';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { ErrorBoundary } from "@/components/error/ErrorBoundary";
import { MainLayout } from "@/components/layout";
import { Skeleton } from "@/components/ui/skeleton";

// Lazy load pages for code splitting
const Dashboard = lazy(() => import("./pages/Dashboard"));
const SkillGraphPage = lazy(() => import("./pages/SkillGraphPage"));
const ResumeUploadPage = lazy(() => import("./pages/ResumeUploadPage"));
const GapAnalysisPage = lazy(() => import("./pages/GapAnalysisPage"));
const LearningPathPage = lazy(() => import("./pages/LearningPathPage"));
const TrendsPage = lazy(() => import("./pages/TrendsPage"));
const QuizPage = lazy(() => import("./pages/QuizPage"));
const WhatIfPage = lazy(() => import("./pages/WhatIfPage"));
const ProfilePage = lazy(() => import("./pages/ProfilePage"));
const NotFound = lazy(() => import("./pages/NotFound"));

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 5 * 60 * 1000,
      retry: (failureCount, error: unknown) => {
        // Don't retry on 4xx errors
        if (error && typeof error === 'object' && 'response' in error) {
          const axiosError = error as { response?: { status?: number } };
          const status = axiosError.response?.status;
          if (status && status >= 400 && status < 500) {
            return false;
          }
        }
        return failureCount < 2;
      },
      refetchOnWindowFocus: false,
      refetchOnReconnect: true,
    },
    mutations: {
      retry: 1,
    },
  },
});

const PageSkeleton = () => (
  <div className="space-y-6">
    <Skeleton className="h-10 w-64" />
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
      {[...Array(4)].map((_, i) => (
        <Skeleton key={i} className="h-32 rounded-lg" />
      ))}
    </div>
    <Skeleton className="h-64 rounded-lg" />
  </div>
);

const App = () => (
  <ErrorBoundary>
    <QueryClientProvider client={queryClient}>
      <TooltipProvider>
        <Toaster />
        <Sonner />
        <BrowserRouter>
          <MainLayout>
            <Suspense fallback={<PageSkeleton />}>
              <ErrorBoundary>
                <Routes>
                  <Route path="/" element={<Dashboard />} />
                  <Route path="/skills" element={<SkillGraphPage />} />
                  <Route path="/resume" element={<ResumeUploadPage />} />
                  <Route path="/gap-analysis" element={<GapAnalysisPage />} />
                  <Route path="/learning" element={<LearningPathPage />} />
                  <Route path="/trends" element={<TrendsPage />} />
                  <Route path="/quizzes" element={<QuizPage />} />
                  <Route path="/what-if" element={<WhatIfPage />} />
                  <Route path="/profile" element={<ProfilePage />} />
                  <Route path="*" element={<NotFound />} />
                </Routes>
              </ErrorBoundary>
            </Suspense>
          </MainLayout>
        </BrowserRouter>
      </TooltipProvider>
      {import.meta.env.DEV && <ReactQueryDevtools initialIsOpen={false} />}
    </QueryClientProvider>
  </ErrorBoundary>
);

export default App;
