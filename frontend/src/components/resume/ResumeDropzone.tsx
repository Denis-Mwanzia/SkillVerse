import { useCallback, useState } from 'react';
import { useDropzone } from 'react-dropzone';
import { motion, AnimatePresence } from 'framer-motion';
import { Upload, FileText, X, CheckCircle, Loader2 } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { cn } from '@/lib/utils';

interface ResumeDropzoneProps {
  onUpload: (file: File) => Promise<void>;
  isUploading: boolean;
  uploadProgress?: number;
}

export function ResumeDropzone({ onUpload, isUploading, uploadProgress }: ResumeDropzoneProps) {
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [error, setError] = useState<string | null>(null);

  const onDrop = useCallback((acceptedFiles: File[], rejectedFiles: unknown[]) => {
    setError(null);
    
    if (rejectedFiles.length > 0) {
      setError('Please upload a PDF, DOCX, or TXT file under 8MB');
      return;
    }

    const file = acceptedFiles[0];
    if (file) {
      setSelectedFile(file);
    }
  }, []);

  const { getRootProps, getInputProps, isDragActive } = useDropzone({
    onDrop,
    accept: {
      'application/pdf': ['.pdf'],
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document': ['.docx'],
      'text/plain': ['.txt'],
    },
    maxSize: 8 * 1024 * 1024, // 8MB
    multiple: false,
    disabled: isUploading,
  });

  const handleUpload = async () => {
    if (selectedFile) {
      try {
        await onUpload(selectedFile);
      } catch {
        setError('Upload failed. Please try again.');
      }
    }
  };

  const handleRemove = () => {
    setSelectedFile(null);
    setError(null);
  };

  return (
    <div className="space-y-4">
      <div
        {...getRootProps()}
        className={cn(
          'relative border-2 border-dashed rounded-lg p-8 text-center transition-all cursor-pointer',
          isDragActive
            ? 'border-primary bg-primary/5'
            : 'border-border hover:border-primary/50 hover:bg-accent/30',
          isUploading && 'pointer-events-none opacity-60'
        )}
      >
        <input {...getInputProps()} />
        
        <AnimatePresence mode="wait">
          {isUploading ? (
            <motion.div
              key="uploading"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              className="flex flex-col items-center"
            >
              <Loader2 className="h-12 w-12 text-primary animate-spin" />
              <p className="mt-4 text-lg font-medium text-card-foreground">
                Analyzing your resume...
              </p>
              <p className="text-sm text-muted-foreground mt-1">
                {uploadProgress ? `${uploadProgress}% complete` : 'Extracting skills and experience'}
              </p>
            </motion.div>
          ) : selectedFile ? (
            <motion.div
              key="selected"
              initial={{ opacity: 0, scale: 0.9 }}
              animate={{ opacity: 1, scale: 1 }}
              exit={{ opacity: 0, scale: 0.9 }}
              className="flex flex-col items-center"
            >
              <div className="relative">
                <FileText className="h-12 w-12 text-primary" />
                <CheckCircle className="absolute -bottom-1 -right-1 h-5 w-5 text-primary bg-card rounded-full" />
              </div>
              <p className="mt-4 text-lg font-medium text-card-foreground">{selectedFile.name}</p>
              <p className="text-sm text-muted-foreground">
                {(selectedFile.size / 1024 / 1024).toFixed(2)} MB
              </p>
              <Button
                variant="ghost"
                size="sm"
                className="mt-2 text-muted-foreground hover:text-destructive"
                onClick={(e) => {
                  e.stopPropagation();
                  handleRemove();
                }}
              >
                <X className="h-4 w-4 mr-1" /> Remove
              </Button>
            </motion.div>
          ) : (
            <motion.div
              key="empty"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              className="flex flex-col items-center"
            >
              <Upload className={cn('h-12 w-12', isDragActive ? 'text-primary' : 'text-muted-foreground')} />
              <p className="mt-4 text-lg font-medium text-card-foreground">
                {isDragActive ? 'Drop your resume here' : 'Drag & drop your resume'}
              </p>
              <p className="text-sm text-muted-foreground mt-1">
                or click to browse (PDF, DOCX, TXT up to 8MB)
              </p>
            </motion.div>
          )}
        </AnimatePresence>
      </div>

      {error && (
        <motion.p
          initial={{ opacity: 0, y: -10 }}
          animate={{ opacity: 1, y: 0 }}
          className="text-sm text-destructive text-center"
        >
          {error}
        </motion.p>
      )}

      {selectedFile && !isUploading && (
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex justify-center"
        >
          <Button onClick={handleUpload} size="lg" className="min-w-40">
            Analyze Resume
          </Button>
        </motion.div>
      )}
    </div>
  );
}
