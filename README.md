# Skillverse – Smart Career Path Navigator

> AI-powered career navigation platform that helps users understand where they are, where they want to go, and exactly how to get there—using real-time job-market intelligence and explainable skill graphs.

## 🎯 Vision

Skillverse is a Jac full-stack, AI-powered career navigation platform designed to bridge the gap between where professionals are today and where they want to be tomorrow. By leveraging real-time job-market intelligence and explainable skill graphs, Skillverse provides personalized, actionable guidance for career advancement.

## 🏗️ Architecture Overview

### Frontend Stack
- **React 18** + **Vite** – Modern, fast UI framework
- **TailwindCSS** – Utility-first CSS for rapid styling
- **Zustand** – Lightweight client-side state management
- **Framer Motion** – Polished animations and transitions
- **React Hook Form** – Structured user input handling
- **Jac Client** – Seamless communication with backend walkers
- **React Flow** – Visual skill graph navigation
- **Recharts** – Skill demand trends visualization
- **Socket.io-client** – Real-time market intelligence updates

### Backend Stack
- **JacLang** – AI-native programming language
- **OSP Graph** – Graph modeling of users, skills, roles, courses, certifications, and job postings
- **Walkers** – Resume parsing, graph updates, job-market ingestion, and progress tracking
- **byLLM** – AI-powered extraction, gap analysis, summarization, and roadmap generation

## 📋 Platform Structure

### Public Portfolio (Before Login / Signup)

Before authentication, Skillverse functions as a professional product portfolio:

- **Home** – Vision, value proposition, and how Skillverse works
- **About** – Product details and "Built by: a team of 3"
- **Contact** – Feedback and inquiry form
- **Get Started** – Login / Signup entry point

This stage focuses on branding, clarity, and trust-building.

### Authenticated Platform (After Login / Signup)

Once authenticated, users unlock the full Skillverse experience:

#### 1. Resume / CV Intelligence (byLLM-powered)
- Users upload a resume/CV
- byLLM extracts structured data:
  - Skills (technical & soft)
  - Certifications
  - Education background
  - Work experience
  - Tools and technologies
- Extracted data is mapped directly into the OSP graph as nodes and edges

#### 2. Career Target Selection
- Users select:
  - Target job roles
  - Career tracks
  - Emerging or high-growth skills
- Roles and skills are pulled from live job-market signals

#### 3. Skill Gap Analysis (byLLM)
- byLLM compares:
  - Current skill graph (from resume + progress)
  - Required skills for selected roles
  - Emerging market-demand skills
- Identifies:
  - Missing skills
  - Weak or outdated skills
  - Priority skills based on demand

#### 4. Personalized Learning Roadmap
- byLLM generates a step-by-step learning roadmap:
  - Courses (online, certifications, bootcamps)
  - Projects to build practical experience
  - Recommended timelines and milestones
- Roadmap adapts dynamically as:
  - User completes milestones
  - Market demand changes

#### 5. Visual Career Navigation
- **React Flow** displays:
  - Skill → Course → Role relationships
  - Clear visual explanation of how learning leads to careers
- **Recharts** shows:
  - Skill demand trends
  - Role popularity over time

#### 6. Progress Tracking & Feedback
- Users:
  - Mark skills as learned
  - Upload certificates
  - Log completed projects
- Walkers update the OSP graph instantly via Jac Client `spawn()`

#### 7. Real-Time Market Intelligence
- Socket.io-client pushes:
  - Alerts for emerging high-demand skills
  - Notifications when user-selected roles shift in demand
- Learning plans are automatically revised

#### 8. Smart Recommendations
- Suggested:
  - Portfolio projects aligned with target roles
  - Certifications with highest ROI
  - Alternative career paths based on existing skills
  - Career readiness score indicating how close a user is to a role
  - Resume improvement tips generated from skill gaps
  - Periodic re-analysis without re-uploading CV

## 🚀 Getting Started

### Running Jac Code

Make sure node modules are installed:
```bash
npm install
```

To run your Jac code, use the Jac CLI:
```bash
jac serve app.jac
```

## 📦 Project Structure

```
Skillverse/
├── app.jac          # Main Jac application file
├── nodes.jac        # Graph node and edge definitions
├── package.json     # Node.js dependencies
├── public/          # Static assets
└── static/          # Additional static resources
```

## 🔑 Key Features

- ✅ **Explainable Skill Graphs** – Visual representation of skill relationships
- ✅ **Real-Time Market Intelligence** – Live job-market signals and alerts
- ✅ **AI-Powered Analysis** – byLLM for resume parsing and gap analysis
- ✅ **Dynamic Learning Roadmaps** – Adaptive plans that evolve with market changes
- ✅ **Progress Tracking** – Real-time graph updates as users learn and grow
- ✅ **Smart Recommendations** – Data-driven career guidance

## 📄 License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.

## 👥 Team

Built by a team of 3 passionate developers:

- **Denis Mwanzia**
- **Doris Muasya**
- **James Ngaruiya**

## 🏆 Hackathon

This project was developed as part of a hackathon organized by:

- **The Open University of Kenya (OUK)**
- **BCS Technology International Pty Limited, Australia**

---

**Ready to navigate your career path? Let's build Skillverse!** 🚀
