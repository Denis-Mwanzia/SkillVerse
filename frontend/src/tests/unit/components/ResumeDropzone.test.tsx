import { describe, it, expect, vi } from 'vitest';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { ResumeDropzone } from '@/components/resume/ResumeDropzone';

describe('ResumeDropzone', () => {
  const mockOnUpload = vi.fn().mockResolvedValue(undefined);

  it('renders dropzone', () => {
    render(<ResumeDropzone onUpload={mockOnUpload} isUploading={false} />);
    expect(screen.getByText(/Drag & drop your resume/i)).toBeInTheDocument();
  });

  it('shows uploading state', () => {
    render(<ResumeDropzone onUpload={mockOnUpload} isUploading={true} uploadProgress={50} />);
    expect(screen.getByText(/Analyzing your resume/i)).toBeInTheDocument();
    expect(screen.getByText(/50% complete/i)).toBeInTheDocument();
  });

  it('accepts file selection', async () => {
    const file = new File(['test'], 'test.pdf', { type: 'application/pdf' });
    render(<ResumeDropzone onUpload={mockOnUpload} isUploading={false} />);
    
    const input = screen.getByRole('textbox', { hidden: true }) as HTMLInputElement;
    Object.defineProperty(input, 'files', {
      value: [file],
      writable: false,
    });

    fireEvent.change(input);
    
    await waitFor(() => {
      expect(screen.getByText(/test.pdf/i)).toBeInTheDocument();
    });
  });
});

