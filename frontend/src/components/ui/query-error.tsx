import { AlertCircle, RefreshCw } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Alert, AlertDescription, AlertTitle } from '@/components/ui/alert';
import { UseQueryResult } from '@tanstack/react-query';

interface QueryErrorProps {
  error: Error | unknown;
  refetch?: () => void;
  title?: string;
  description?: string;
}

export function QueryError({ error, refetch, title, description }: QueryErrorProps) {
  const errorMessage = error instanceof Error ? error.message : 'An error occurred while loading data';
  
  return (
    <Alert variant="destructive" className="max-w-2xl mx-auto">
      <AlertCircle className="h-4 w-4" />
      <AlertTitle>{title || 'Failed to load data'}</AlertTitle>
      <AlertDescription className="mt-2">
        {description || errorMessage}
      </AlertDescription>
      {refetch && (
        <Button
          onClick={() => refetch()}
          variant="outline"
          size="sm"
          className="mt-4"
        >
          <RefreshCw className="h-4 w-4 mr-2" />
          Retry
        </Button>
      )}
    </Alert>
  );
}

export function handleQueryError<TData, TError>(
  query: UseQueryResult<TData, TError>
): { isLoading: boolean; isError: boolean; error: TError | null; data: TData | undefined } {
  return {
    isLoading: query.isLoading,
    isError: query.isError,
    error: query.error as TError | null,
    data: query.data,
  };
}

