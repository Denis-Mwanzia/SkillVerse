# SkillVerse

> AI-powered career and skill intelligence platform that helps professionals track skills, analyze gaps, and accelerate career growth with data-driven insights.

## 🚀 Overview

SkillVerse is a comprehensive career intelligence platform built with modern technologies to provide personalized skill tracking, gap analysis, learning path recommendations, and market trend insights. The platform combines AI-powered backend intelligence with a responsive, production-ready frontend.

## ✨ Features

### Core Features
- **📊 Dashboard** - Comprehensive overview of your skills, progress, and career metrics
- **🕸️ Skill Graph** - Interactive visualization of your skill ecosystem and dependencies
- **📄 Resume Analyzer** - AI-powered resume parsing and skill extraction
- **🎯 Gap Analysis** - Identify skill gaps for target roles and positions
- **📚 Learning Path** - Personalized learning recommendations based on your goals
- **📈 Market Trends** - Real-time insights into skill demand and market trends
- **🧠 Skill Quizzes** - Interactive assessments to validate and improve skills
- **💡 What-If Simulator** - Explore career scenarios and potential outcomes
- **👤 User Profile** - Comprehensive profile management with preferences and statistics

### Key Capabilities
- Real-time skill tracking and updates
- AI-powered skill recommendations
- Interactive data visualizations
- Responsive design (mobile, tablet, desktop)
- Dark mode support
- Real-time notifications via WebSocket
- Role-based recommendations with salary insights

## 🏗️ Architecture

SkillVerse is built with a modern full-stack architecture:

```
SkillVerse/
├── backend/          # Jac-based AI backend with FastAPI
│   ├── main.jac      # Main application entry point
│   ├── user_core.jac # User management core
│   ├── walkers_file.jac # Multi-agent walkers
│   └── requirements.txt
└── frontend/         # React + TypeScript frontend
    ├── src/
    │   ├── api/      # API client layer
    │   ├── components/ # React components
    │   ├── pages/    # Route pages
    │   ├── hooks/    # Custom React hooks
    │   ├── store/    # State management
    │   └── utils/    # Utility functions
    └── package.json
```

## 🛠️ Tech Stack

### Backend
- **Jac Language** - AI-native programming language
- **FastAPI** - High-performance Python web framework
- **OSP (Open Service Protocol)** - Service orchestration
- **Gemini 2.5 Flash** - LLM for AI-powered features
- **Uvicorn** - ASGI server

### Frontend
- **React 18** - Modern UI library
- **TypeScript** - Type-safe JavaScript
- **Vite** - Next-generation build tool
- **TailwindCSS** - Utility-first CSS framework
- **React Router v6** - Client-side routing
- **TanStack Query** - Server state management
- **Zustand** - Lightweight state management
- **Framer Motion** - Animation library
- **React Flow** - Graph visualization
- **Recharts** - Chart library
- **Axios** - HTTP client
- **Socket.io-client** - Real-time communication
- **Zod** - Schema validation
- **React Hook Form** - Form management

## 📦 Prerequisites

### Backend
- Python 3.9+
- Jac Language runtime
- Gemini API key (or compatible LLM API)

### Frontend
- Node.js 18+ or Bun
- npm, yarn, or bun package manager

## 🚀 Getting Started

### Backend Setup

1. Navigate to the backend directory:
```bash
cd backend
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Set up environment variables:
```bash
# Create a .env file
GEMINI_API_KEY=your_api_key_here
```

4. Run the backend server:
```bash
# Start FastAPI server
uvicorn main:app --reload

# Or run Jac application
jac run main.jac
```

### Frontend Setup

1. Navigate to the frontend directory:
```bash
cd frontend
```

2. Install dependencies:
```bash
npm install
# or
yarn install
# or
bun install
```

3. Create environment file:
```bash
# Create .env.local
VITE_API_URL=http://localhost:8000
```

4. Start the development server:
```bash
npm run dev
# or
yarn dev
# or
bun dev
```

The application will be available at `http://localhost:5173`

## 📝 Available Scripts

### Frontend Scripts

```bash
# Development
npm run dev              # Start development server
npm run build           # Build for production
npm run preview         # Preview production build

# Testing
npm test                # Run unit tests
npm run test:ui         # Run tests with UI
npm run test:coverage   # Generate coverage report
npm run test:e2e        # Run E2E tests
npm run test:e2e:open   # Open Cypress UI

# Code Quality
npm run lint            # Run ESLint
```

## 🌐 API Endpoints

### Authentication
- `POST /api/auth/login` - User login
- `POST /api/auth/register` - User registration
- `GET /api/auth/profile` - Get user profile
- `PATCH /api/auth/profile` - Update profile
- `POST /api/auth/change-password` - Change password

### Skills
- `GET /api/skill-graph/{user_id}` - Get skill graph
- `POST /api/skills` - Add new skill
- `PUT /api/skills/{skill_id}` - Update skill
- `POST /api/upload-resume` - Upload and parse resume

### Career Intelligence
- `GET /api/gap-analysis/{user_id}` - Get gap analysis
- `GET /api/learning-path/{user_id}` - Get learning recommendations
- `GET /api/role-recommendations/{user_id}` - Get role suggestions
- `GET /api/trend-signals` - Get market trends

### Learning
- `GET /api/quizzes/{skill_id}` - Get quiz for skill
- `POST /api/quiz-submit` - Submit quiz answers

### Simulation
- `POST /api/what-if` - Run career scenario simulation

### Dashboard
- `GET /api/dashboard/{user_id}` - Get dashboard data

## 🎨 UI Components

The frontend uses a component-based architecture with reusable UI components:

- **Layout Components** - Navbar, Sidebar, Footer
- **Dashboard Components** - Stats, Charts, Activity feeds
- **Form Components** - Inputs, Selects, Validation
- **Data Visualization** - Graphs, Charts, Skill badges
- **Interactive** - Modals, Drawers, Tooltips

## 🔒 Environment Variables

### Frontend (.env.local)
```env
VITE_API_URL=http://localhost:8000
VITE_SOCKET_URL=ws://localhost:8000
```

### Backend (.env)
```env
GEMINI_API_KEY=your_api_key
DATABASE_URL=your_database_url
SECRET_KEY=your_secret_key
```

## 🧪 Testing

### Unit Tests
```bash
npm test
```

### E2E Tests
```bash
npm run test:e2e
```

### Test Coverage
```bash
npm run test:coverage
```

## 📦 Building for Production

### Frontend
```bash
npm run build
```

The production build will be in the `dist/` directory, ready for deployment.

### Docker Deployment

A Dockerfile is included for containerized deployment:

```bash
docker build -t skillverse-frontend ./frontend
docker run -p 80:80 skillverse-frontend
```

## 🌟 Key Features Deep Dive

### Skill Graph
- Interactive node-edge visualization
- Drag, zoom, and pan capabilities
- Skill dependencies and relationships
- Real-time updates via WebSocket

### Gap Analysis
- Compare current skills with target roles
- Priority-based gap identification
- Actionable learning recommendations

### What-If Simulator
- Scenario-based career planning
- Salary range projections
- Effort estimation
- Match score improvements

### Learning Path
- Personalized course recommendations
- Progress tracking
- Milestone-based learning
- ETA calculations

## 📱 Responsive Design

SkillVerse is fully responsive and optimized for:
- 📱 Mobile devices (320px+)
- 📱 Tablets (768px+)
- 💻 Desktop (1024px+)
- 🖥️ Large screens (1280px+)

## 🎯 Performance

- Code splitting and lazy loading
- Optimized bundle sizes
- Skeleton loaders for better UX
- Efficient state management
- Real-time updates with minimal overhead

## 🔐 Security

- JWT-based authentication
- Token refresh mechanism
- Secure password handling
- CORS configuration
- Input validation and sanitization

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the terms specified in the LICENSE file.

## 🙏 Acknowledgments

- Built with [Jac Language](https://github.com/Jaseci-Labs/jaseci)
- UI components inspired by [shadcn/ui](https://ui.shadcn.com)
- Icons from [Lucide React](https://lucide.dev)

## 📞 Support

For support, please open an issue in the GitHub repository or contact the development team.

---

**Built with ❤️ by the SkillVerse team**
