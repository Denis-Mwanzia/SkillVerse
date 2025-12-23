# ============================
# CORE NODE TYPES
# ============================

node User {
    has name: str;
    has experience_level: str;   # beginner | intermediate | senior
    has goals: list[str];
    has last_active: datetime;
}

node Skill {
    has name: str;
    has category: str;           # e.g. ML, Backend, DevOps
    has mastery: float = 0.0;    # 0.0 – 1.0
    has demand_score: float = 0.0;
}

node Role {
    has title: str;
    has industry: str;
    has seniority: str;
}

node Course {
    has title: str;
    has provider: str;
    has difficulty: str;
    has duration_hours: int;
}

node JobPosting {
    has company: str;
    has title: str;
    has location: str;
    has posted_at: datetime;
}

node TrendSignal {
    has source: str;             # e.g. LinkedIn, Kaggle, GitHub
    has strength: float;         # confidence score
    has detected_at: datetime;
}

# ============================
# EDGE TYPES
# ============================

edge HAS_SKILL {
    has confidence: float;       # inferred confidence from resume / quiz
}

edge REQUIRES_SKILL {
    has weight: float;           # importance for role
}

edge COURSE_TEACHES {
    has depth: float;            # how deeply course teaches skill
}

edge USER_TARGET_ROLE {}

edge TRENDING_SKILL {
    has momentum: float;
}

edge JOB_REQUIRES_SKILL {}

edge ROLE_ALTERNATIVE {
    has similarity_score: float;
}
