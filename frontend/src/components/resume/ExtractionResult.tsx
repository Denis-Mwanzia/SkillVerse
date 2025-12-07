import { motion } from 'framer-motion';
import { Check, Plus, Briefcase, GraduationCap, Lightbulb } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { SkillBadge } from '@/components/ui/skill-badge';
import type { ResumeUploadResponse, Skill } from '@/types/api';

interface ExtractionResultProps {
  data: ResumeUploadResponse;
  onConfirmSkills: (skills: Skill[]) => void;
  onAddToGraph: () => void;
}

export function ExtractionResult({ data, onAddToGraph }: ExtractionResultProps) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.4 }}
      className="space-y-6"
    >
      {/* Success Header */}
      <div className="text-center">
        <motion.div
          initial={{ scale: 0 }}
          animate={{ scale: 1 }}
          transition={{ duration: 0.3, delay: 0.2 }}
          className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-primary/20 mb-4"
        >
          <Check className="h-8 w-8 text-primary" />
        </motion.div>
        <h2 className="text-2xl font-bold text-card-foreground">Resume Analyzed!</h2>
        <p className="text-muted-foreground mt-1">
          We found {data.extractedSkills.length} skills and {data.experience.length} experiences
        </p>
      </div>

      {/* Extracted Skills */}
      <div className="rounded-lg border border-border bg-card p-6">
        <h3 className="font-semibold text-card-foreground mb-4 flex items-center gap-2">
          <Plus className="h-5 w-5 text-primary" />
          Extracted Skills
        </h3>
        <div className="flex flex-wrap gap-2">
          {data.extractedSkills.map((skill, index) => (
            <motion.div
              key={skill.id}
              initial={{ opacity: 0, scale: 0.8 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ duration: 0.2, delay: 0.3 + index * 0.05 }}
            >
              <SkillBadge
                name={skill.name}
                level={skill.level}
                proficiency={skill.proficiency}
                showLevel
              />
            </motion.div>
          ))}
        </div>
      </div>

      {/* Experience */}
      <div className="rounded-lg border border-border bg-card p-6">
        <h3 className="font-semibold text-card-foreground mb-4 flex items-center gap-2">
          <Briefcase className="h-5 w-5 text-primary" />
          Work Experience
        </h3>
        <div className="space-y-4">
          {data.experience.map((exp, index) => (
            <motion.div
              key={exp.id}
              initial={{ opacity: 0, x: -10 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.2, delay: 0.4 + index * 0.1 }}
              className="flex items-start gap-3 p-3 rounded-lg bg-background"
            >
              <div className="p-2 rounded-lg bg-primary/10">
                <Briefcase className="h-4 w-4 text-primary" />
              </div>
              <div>
                <p className="font-medium text-card-foreground">{exp.role}</p>
                <p className="text-sm text-muted-foreground">{exp.company}</p>
                <p className="text-xs text-muted-foreground mt-1">
                  {exp.startDate} - {exp.endDate || 'Present'}
                </p>
              </div>
            </motion.div>
          ))}
        </div>
      </div>

      {/* Education */}
      {data.education.length > 0 && (
        <div className="rounded-lg border border-border bg-card p-6">
          <h3 className="font-semibold text-card-foreground mb-4 flex items-center gap-2">
            <GraduationCap className="h-5 w-5 text-primary" />
            Education
          </h3>
          <div className="space-y-3">
            {data.education.map((edu) => (
              <div key={edu.id} className="p-3 rounded-lg bg-background">
                <p className="font-medium text-card-foreground">{edu.degree} in {edu.field}</p>
                <p className="text-sm text-muted-foreground">{edu.institution} • {edu.year}</p>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Recommendations */}
      {data.recommendations.length > 0 && (
        <div className="rounded-lg border border-border bg-card p-6">
          <h3 className="font-semibold text-card-foreground mb-4 flex items-center gap-2">
            <Lightbulb className="h-5 w-5 text-primary" />
            Recommendations
          </h3>
          <ul className="space-y-2">
            {data.recommendations.map((rec, index) => (
              <li key={index} className="flex items-start gap-2 text-sm text-muted-foreground">
                <span className="text-primary mt-0.5">•</span>
                {rec}
              </li>
            ))}
          </ul>
        </div>
      )}

      {/* Actions */}
      <div className="flex justify-center gap-4">
        <Button size="lg" onClick={onAddToGraph}>
          Add Skills to My Graph
        </Button>
        <Button size="lg" variant="outline">
          Upload Another Resume
        </Button>
      </div>
    </motion.div>
  );
}
