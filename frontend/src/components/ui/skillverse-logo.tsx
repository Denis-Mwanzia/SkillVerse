import { Link } from 'react-router-dom';
import { cn } from '@/lib/utils';

interface SkillVerseLogoProps {
  className?: string;
  showText?: boolean;
  size?: 'sm' | 'md' | 'lg';
  variant?: 'default' | 'sidebar';
}

export function SkillVerseLogo({ 
  className, 
  showText = true, 
  size = 'md',
  variant = 'default'
}: SkillVerseLogoProps) {
  const iconSizes = {
    sm: 'h-8 w-8',
    md: 'h-10 w-10',
    lg: 'h-12 w-12',
  };

  const textSizes = {
    sm: 'text-base',
    md: 'text-lg',
    lg: 'text-xl',
  };

  const LogoIcon = () => (
    <svg
      viewBox="0 0 100 100"
      className={cn(iconSizes[size], 'flex-shrink-0')}
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
    >
      {/* Outer circle */}
      <circle
        cx="50"
        cy="50"
        r="45"
        stroke="currentColor"
        strokeWidth="3"
        className="text-primary"
      />
      
      {/* Top-left dot */}
      <circle
        cx="30"
        cy="30"
        r="6"
        fill="currentColor"
        className="text-primary"
      />
      
      {/* Top-right dot */}
      <circle
        cx="70"
        cy="30"
        r="6"
        fill="currentColor"
        className="text-primary"
      />
      
      {/* Bottom-center dot */}
      <circle
        cx="50"
        cy="75"
        r="6"
        fill="currentColor"
        className="text-primary"
      />
      
      {/* Curved line from top-left to top-right */}
      <path
        d="M 30 30 Q 50 40 70 30"
        stroke="currentColor"
        strokeWidth="2.5"
        fill="none"
        className="text-primary"
      />
      
      {/* Curved line from top-left to bottom-center */}
      <path
        d="M 30 30 Q 40 50 50 75"
        stroke="currentColor"
        strokeWidth="2.5"
        fill="none"
        className="text-primary"
      />
      
      {/* Curved line from top-right to bottom-center */}
      <path
        d="M 70 30 Q 60 50 50 75"
        stroke="currentColor"
        strokeWidth="2.5"
        fill="none"
        className="text-primary"
      />
    </svg>
  );

  const content = (
    <div className={cn('flex items-center gap-3', className)}>
      <LogoIcon />
      {showText && (
        <span className={cn(
          'font-bold text-foreground tracking-tight',
          textSizes[size],
          variant === 'sidebar' && 'hidden lg:block'
        )}>
          SkillVerse
        </span>
      )}
    </div>
  );

  if (variant === 'sidebar') {
    return (
      <Link to="/" className="flex items-center gap-2 hover:opacity-80 transition-opacity">
        {content}
      </Link>
    );
  }

  return content;
}

