import { AlertCircle } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';

interface ErrorFallbackProps {
  error: Error;
  resetErrorBoundary: () => void;
  title?: string;
  message?: string;
}

export function ErrorFallback({ 
  error, 
  resetErrorBoundary,
  title = 'Something went wrong',
  message 
}: ErrorFallbackProps) {
  return (
    <div className="flex items-center justify-center min-h-[400px] p-4">
      <Alert variant="destructive" className="max-w-md">
        <AlertCircle className="h-4 w-4" />
        <AlertTitle>{title}</AlertTitle>
        <AlertDescription className="mt-2">
          {message || error.message || 'An unexpected error occurred. Please try again.'}
        </AlertDescription>
        <Button 
          onClick={resetErrorBoundary} 
          variant="outline" 
          size="sm" 
          className="mt-4"
        >
          Try Again
        </Button>
      </Alert>
    </div>
  );
}

