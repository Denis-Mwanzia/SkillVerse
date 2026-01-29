# Skillverse – Smart Career Path Navigator

> AI-powered career navigation platform that helps users understand where they are, where they want to go, and exactly how to get there—using real-time job-market intelligence and explainable skill graphs.

## 🎯 Vision

Skillverse is a **Jac full-stack**, AI-powered career navigation platform designed to bridge the gap between where professionals are today and where they want to be tomorrow. By leveraging real-time job-market intelligence and explainable skill graphs, Skillverse provides personalized, actionable guidance for career advancement.

## 📺 Demo & Learn More

- **[Watch the Demo](https://drive.google.com/file/d/1DGKSzi5Voi7k1Bw6hyazGQ-JkVlk9rgu/view?usp=sharing)** – See Skillverse in action (Google Drive).
- **[View the Pitch Deck](https://prezi.com/p/edit/uujsstwfrzxn/)** – Visit our Prezi pitch deck to learn more about the product, vision, and roadmap.

---

## 🏗️ Architecture Overview

The app lives in the **Skillverse/** folder. The UI is written in **Jac** (compiles to React) and served by the Jac dev server; the client bundle is built from compiled Jac output.

### Frontend (Jac → React)

- **Jac** – UI and routing in `app.jac` (compiles to React/JSX via Jac client)
- **React 19** + **Vite 7** – Runtime and build
- **Tailwind CSS 4** – Styling
- **React Router** – Client-side routing
- **Framer Motion** – Animations (sidebar, nav, transitions)
- **Lucide React** – Dashboard icons
- **Font Awesome** – Icons across the rest of the app
- **@jac/runtime** – Router, Link, auth helpers (`jacLogin`, `jacLogout`, etc.)

### Backend / Data Model (Jac)

- **JacLang** – Server and app entry (`jac start app.jac`)
- **nodes.jac** – OSP-style graph: `User`, `Skill`, `Role`, `Course`, `JobPosting`, `TrendSignal` and edges (`HAS_SKILL`, `REQUIRES_SKILL`, `COURSE_TEACHES`, etc.)
- **jac.toml** – Project config, `base_route_app = "app"`, client plugin enabled
- **jac-client / jaclang / jac-cloud** – See `Skillverse/requirements.txt`

---

## 📋 Platform Structure

### Public (no login)

| Route     | Page        | Description                                      |
|----------|-------------|--------------------------------------------------|
| `/`      | Home        | Hero, features, how it works, about, contact, CTA |
| `/about` | About       | Mission, values, team                            |
| `/contact` | Contact   | Contact form                                     |
| `/auth`  | Auth        | Login / signup (Get Started)                     |

### Authenticated (dashboard)

| Route        | Page     | Description                                      |
|-------------|----------|--------------------------------------------------|
| `/dashboard` | Dashboard | Single-page dashboard with tabbed content      |

**Dashboard tabs:** Overview, Resume, Career Targets, Skill Gap, Learning Roadmap, Market Intelligence, Progress, Profile.

Once authenticated, users unlock the full Skillverse experience: Resume/CV intelligence (byLLM), career target selection, skill gap analysis, personalized learning roadmap, visual career navigation, progress tracking, real-time market intelligence, and smart recommendations.

---

## 📦 Project Structure

```
SkillVerse/
├── README.md           # This file (project root)
├── LICENSE
├── Skillverse/         # Jac app
│   ├── app.jac         # Main app: routes, pages, dashboard
│   ├── nodes.jac       # Graph node/edge definitions
│   ├── jac.toml        # Jac project config
│   ├── package.json    # Node deps (React, Vite, Tailwind, etc.)
│   ├── requirements.txt # Python: jac-client, jaclang, jac-cloud
│   ├── src/            # Runtime/entry
│   ├── static/         # Static assets
│   └── .jac/client/    # Compiled app, Vite configs
```

---

## 🚀 Getting Started

### Prerequisites

- **Python 3** with `jaclang` and `jac-client`
- **Node.js**

### Run the app

```bash
cd Skillverse
pip install -r requirements.txt
npm install
jac start app.jac
```

Open **http://localhost:8000/** in your browser.

For a quick overview, check out the [pitch deck](https://prezi.com/p/edit/uujsstwfrzxn/).

---

## 🔑 Key Features

- Single Jac codebase (`app.jac`) compiling to React
- Graph model in `nodes.jac` (users, skills, roles, courses, jobs)
- Dashboard: Overview, Resume, Career targets, Skill gap, Learning roadmap, Market intelligence, Progress, Profile
- Framer Motion + Lucide; responsive sidebar; dark/light theme

---

## 📄 License

MIT License – see [LICENSE](LICENSE).

---

## 👥 Team

- **Denis Mwanzia**
- **Doris Muasya**
- **James Ngaruiya**

---

## 🏆 Hackathon

Developed for a hackathon by **The Open University of Kenya (OUK)** and **BCS Technology International Pty Limited, Australia**.

---

**Ready to navigate your career path?** [Watch the demo](https://drive.google.com/file/d/1DGKSzi5Voi7k1Bw6hyazGQ-JkVlk9rgu/view?usp=sharing) or [visit the pitch deck](https://prezi.com/p/edit/uujsstwfrzxn/) to learn more. 🚀
