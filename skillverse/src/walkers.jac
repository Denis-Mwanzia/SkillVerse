import nodes;

import from byllm.lib { Model }

glob llm = Model(model_name="gpt-4o");

# =========================================
# RESUME ANALYZER AGENT
# =========================================

walker ResumeAnalyzer {
    has resume_text: str;

    def llm_extract_skills(resume_text: str) -> list[str] by llm();
    can process_resume with `root entry{
            for skill_name in llm_extract_skills(resume_text) {
                skill_node = spawn Skill(name=skill_name);
                skill_node +>: HAS_SKILL(confidence=0.6);
            }
        }
}

# =========================================
# SKILL GAP ANALYZER
# =========================================

walker GapAnalyzer {
    can analyze gap with `Skill entry {
        for role in --> Role {
            missing = [];
            for req in role +>: REQUIRES_SKILL +>: Skill {
                if not (this +>: HAS_SKILL +>: req) {
                    missing.append(req.name);
                }
            }
            report {
                "role": role.title,
                "missing_skills": missing
            };
        }
    }
}

# =========================================
# LEARNING PATH PLANNER
# =========================================

walker LearningPathPlanner {
    can plan_learning_path with `Skill entry {
        plan = [];

        for skill in --> Skill where skill.mastery < 0.7 {
            for course in skill <-- COURSE_TEACHES {
                plan.append({
                    "skill": skill.name,
                    "course": course.title,
                    "reason": "Skill gap detected"
                });
            }
        }

        report plan;
    }
}

# =========================================
# MARKET TREND INTERPRETER
# =========================================

walker MarketTrendInterpreter {
    can interpret_trends with `TrendSignal entry {
        for trend in --> TrendSignal {
            for skill in trend +>: TRENDING_SKILL +>: Skill {
                skill.demand_score += trend.strength * 0.1;
            }
        }
    }
}

# =========================================
# QUIZ GENERATOR AGENT
# =========================================

walker QuizGenerator {
    has target_skill: str;

    def llm_generate_quiz(skill_name: str) -> list[str] by llm();

    can generate_quiz with `Skill entry {
        questions = llm_generate_quiz(target_skill);
        report questions;
    }
}

# =========================================
# MULTI-ROLE RECOMMENDER
# =========================================

walker MultiRoleRecommender {
    can recommend_roles with `Skill entry {
        roles = [];

        for role in --> Role {
            overlap = 0;
            for skill in this +>: HAS_SKILL +>: Skill {
                if role +>: REQUIRES_SKILL +>: skill {
                    overlap += 1;
                }
            }
            roles.append({
                "role": role.title,
                "overlap_score": overlap
            });
        }

        report roles;
    }
}

# =========================================
# PREDICTIVE TREND AGENT
# =========================================

walker PredictiveTrendAgent {
    can predict_demand with `Skill entry {
        for skill in --> Skill {
            skill.demand_score = llm_predict_demand(skill.name);
        }
    }
}

# =========================================
# WHAT-IF SIMULATOR
# =========================================

walker WhatIfSimulator {
    has hypothetical_skills: list[str];

    can simulate with `Skillentry {
        for s in hypothetical_skills {
            temp = spawn Skill(name=s, mastery=0.5);
            edge (this -> temp) : HAS_SKILL(confidence=0.5);
        }

        spawn GapAnalyzer;
        spawn LearningPathPlanner;
    }
}
