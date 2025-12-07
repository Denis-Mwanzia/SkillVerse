import { useState } from 'react';
import { ResumeDropzone, ExtractionResult } from '@/components/resume';
import { skillsApi } from '@/api/skills';
import { toast } from '@/hooks/use-toast';
import type { ResumeUploadResponse } from '@/types/api';

export default function ResumeUploadPage() {
  const [isUploading, setIsUploading] = useState(false);
  const [result, setResult] = useState<ResumeUploadResponse | null>(null);

  const handleUpload = async (file: File) => {
    setIsUploading(true);
    try {
      const data = await skillsApi.uploadResume(file);
      setResult(data);
      toast({ title: 'Resume analyzed!', description: `Found ${data.extractedSkills.length} skills` });
    } finally {
      setIsUploading(false);
    }
  };

  return (
    <div className="max-w-3xl mx-auto space-y-6">
      <div className="text-center">
        <h1 className="text-2xl font-bold text-foreground">Resume Analyzer</h1>
        <p className="text-muted-foreground">Upload your resume to extract skills and experience</p>
      </div>

      {result ? (
        <ExtractionResult
          data={result}
          onConfirmSkills={() => {}}
          onAddToGraph={() => toast({ title: 'Skills added to your graph!' })}
        />
      ) : (
        <ResumeDropzone onUpload={handleUpload} isUploading={isUploading} />
      )}
    </div>
  );
}
