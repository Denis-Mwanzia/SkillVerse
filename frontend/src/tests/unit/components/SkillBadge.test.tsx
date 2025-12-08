import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import { SkillBadge } from '@/components/ui/skill-badge';

describe('SkillBadge', () => {
  it('renders skill name', () => {
    render(<SkillBadge name="React" />);
    expect(screen.getByText('React')).toBeInTheDocument();
  });

  it('displays proficiency level correctly', () => {
    const { container } = render(<SkillBadge name="TypeScript" proficiency="advanced" />);
    const badge = container.firstChild as HTMLElement;
    expect(badge).toHaveAttribute('aria-label', expect.stringContaining('advanced'));
  });

  it('shows level when showLevel is true', () => {
    render(<SkillBadge name="JavaScript" level={85} showLevel />);
    expect(screen.getByText('85')).toBeInTheDocument();
  });

  it('has correct ARIA label', () => {
    render(<SkillBadge name="Python" level={75} proficiency="intermediate" />);
    const badge = screen.getByLabelText(/Python skill at 75% proficiency - intermediate level/);
    expect(badge).toBeInTheDocument();
  });

  it('applies correct size classes', () => {
    const { container } = render(<SkillBadge name="Go" size="sm" />);
    const badge = container.firstChild as HTMLElement;
    expect(badge.className).toContain('text-xs');
  });
});

