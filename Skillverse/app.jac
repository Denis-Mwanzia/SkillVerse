# Skillverse Career Navigation Platform
# Import node and edge definitions
include nodes;

cl import from "react" {useState, useEffect}
cl import from "@jac/runtime" {
    Router,
    Routes,
    Route,
    Link,
    useNavigate,
    jacSpawn,
    jacSignup,
    jacLogin,
    jacLogout,
    jacIsLoggedIn
}
cl import from "@fortawesome/react-fontawesome" {FontAwesomeIcon}
cl import from "@fortawesome/free-solid-svg-icons" {faFileText, faBullseye, faChartLine, faMap, faArrowRight, faMagic, faInfoCircle, faEnvelope, faHeart, faLightbulb, faBolt, faTrophy, faCode, faClock, faCrown, faAward, faRocket, faUser, faLock, faEye, faEyeSlash, faArrowLeft, faSun, faMoon, faBars, faTimes, faArrowUp, faBook, faGlobe, faWandMagicSparkles, faBell, faCog, faSignOutAlt, faUpload, faPlus, faCheckCircle, faChevronRight, faProjectDiagram, faCircleNotch, faGraduationCap, faBriefcase, faSearch, faExclamationCircle, faExclamationTriangle, faBarChart, faPlay, faCalendar, faArrowDown, faZap, faCamera, faEdit, faSave, faMapPin, faLink}
cl import from "@fortawesome/free-brands-svg-icons" {faXTwitter, faLinkedin, faGithub, faGoogle}
cl import from "framer-motion" { motion, AnimatePresence }
cl import from "lucide-react" { BarChart3, FileText, Target, TrendingUp, BookOpen, Network, Sparkles, User, Settings, LogOut, Menu, X, Bell }
cl import ".static/main.css";

# Main App Component with Routing
cl {
    # Wrapper to remove favicon from tab and set page title
    def AppWrapper() -> any {
        useEffect(lambda: None -> None {
            links = document.querySelectorAll("link[rel*=\"icon\"]");
            for i in range(links.length) {
                links[i].remove();
            }
            document.title = "Skillverse";
        }, []);
        return <Router>
            <Routes>
                <Route path="/" element={<IndexPage />} />
                <Route path="/about" element={<AboutPage />} />
                <Route path="/contact" element={<ContactPage />} />
                <Route path="/auth" element={<AuthPage />} />
                <Route path="/dashboard" element={<DashboardPage />} />
            </Routes>
        </Router>;
    }
    def:pub app() -> any {
        return <AppWrapper />;
    }
    
    # Index/Home Page - Matching skill-navigator exactly
    def IndexPage() -> any {
        return <div className="min-h-screen bg-background overflow-hidden">
            <Navbar />
            <HeroSection />
            <FeaturesSection />
            <HowItWorksSection />
            <AboutSection />
            <ContactSection />
            <CTASection />
            <Footer />
        </div>;
    }
    
    # Theme Toggle Component
    def ThemeToggle() -> any {
        # Toggle theme function
        def toggleTheme() -> None {
            isDark = document.documentElement.classList.contains("dark");
            if (isDark) {
                document.documentElement.classList.remove("dark");
                localStorage.setItem("theme", "light");
            } else {
                document.documentElement.classList.add("dark");
                localStorage.setItem("theme", "dark");
            }
            
        }
        
        return <button
            onClick={toggleTheme}
            className="p-2 rounded-full hover:bg-secondary transition-colors duration-300 text-foreground"
            aria-label="Toggle theme"
        >
            <span className="dark:hidden">
                <FontAwesomeIcon icon={faMoon} className="w-5 h-5" />
            </span>
            <span className="hidden dark:inline">
                <FontAwesomeIcon icon={faSun} className="w-5 h-5" />
            </span>
        </button>;
    }
    
    # Navbar Component - Matching skill-navigator layout with mobile menu
    def Navbar() -> any {
        # Mobile menu state
        isMenuOpen = useState(false);
        menuOpen = isMenuOpen[0];
        setMenuOpen = isMenuOpen[1];
        
        # Toggle mobile menu
        def toggleMenu() -> None {
            setMenuOpen(not menuOpen);
        }
        
        # Close menu when link is clicked
        def closeMenu() -> None {
            setMenuOpen(false);
        }
        
        # Determine menu icon
        menuIcon = None;
        if (menuOpen) {
            menuIcon = <FontAwesomeIcon icon={faTimes} className="w-5 h-5" />;
        } else {
            menuIcon = <FontAwesomeIcon icon={faBars} className="w-5 h-5" />;
        }
        
        # Determine menu content visibility
        menuContent = None;
        if (menuOpen) {
            menuContent = <div className="md:hidden overflow-hidden">
                <div className="py-4 border-t border-border/50 bg-background/95 backdrop-blur-sm">
                    <div className="flex flex-col gap-1.5">
                        <Link to="/" onClick={closeMenu} className="px-4 py-3.5 rounded-xl font-medium transition-all duration-200 cursor-pointer flex items-center gap-3 relative group text-muted-foreground hover:bg-secondary/50 hover:text-foreground">
                            <FontAwesomeIcon icon={faMagic} className="w-5 h-5 group-hover:text-primary" />
                            <span className="flex-1">Features</span>
                        </Link>
                        <Link to="/about" onClick={closeMenu} className="px-4 py-3.5 rounded-xl font-medium transition-all duration-200 cursor-pointer flex items-center gap-3 relative group text-muted-foreground hover:bg-secondary/50 hover:text-foreground">
                            <FontAwesomeIcon icon={faInfoCircle} className="w-5 h-5 group-hover:text-primary" />
                            <span className="flex-1">About</span>
                        </Link>
                        <Link to="/contact" onClick={closeMenu} className="px-4 py-3.5 rounded-xl font-medium transition-all duration-200 cursor-pointer flex items-center gap-3 relative group text-muted-foreground hover:bg-secondary/50 hover:text-foreground">
                            <FontAwesomeIcon icon={faEnvelope} className="w-5 h-5 group-hover:text-primary" />
                            <span className="flex-1">Contact</span>
                        </Link>
                        <div className="flex flex-col gap-2 pt-4 mt-2 border-t border-border/50">
                            <Link to="/auth" onClick={closeMenu}>
                                <button className="w-full h-12 px-6 rounded-xl font-semibold bg-gradient-primary text-white shadow-lg shadow-primary/20 hover:shadow-xl hover:shadow-primary/30 transition-all duration-300">
                                    Get Started
                                </button>
                            </Link>
                        </div>
                    </div>
                </div>
            </div>;
        }
        
        return <nav className="fixed top-0 left-0 right-0 z-50 transition-all duration-300 glass-strong shadow-lg shadow-primary/5 backdrop-blur-xl border-b border-border/50">
            <div className="container mx-auto px-4 sm:px-6 lg:px-8">
                <div className="flex items-center justify-between h-28 md:h-32 lg:h-36">
                    <Link to="/" className="flex items-center group relative">
                        <div className="relative">
                            <img 
                                src="/assets/illustrations/logo.png" 
                                alt="Skillverse Logo" 
                                className="w-32 h-32 sm:w-36 sm:h-36 md:w-40 md:h-40 lg:w-44 lg:h-44 xl:w-48 xl:h-48 object-contain group-hover:opacity-90 transition-opacity duration-300 group-hover:scale-105 transition-transform duration-300"
                            />
                        </div>
                    </Link>

                    # Desktop Navigation
                    <div className="hidden md:flex items-center gap-1">
                        <Link to="/" className="relative px-4 py-2.5 rounded-lg font-medium text-sm transition-all duration-300 cursor-pointer flex items-center gap-2.5 group text-muted-foreground hover:text-foreground">
                            <FontAwesomeIcon icon={faMagic} className="w-4 h-4 transition-all duration-300 group-hover:text-primary group-hover:scale-110" />
                            <span className="font-medium">Features</span>
                        </Link>
                        <Link to="/about" className="relative px-4 py-2.5 rounded-lg font-medium text-sm transition-all duration-300 cursor-pointer flex items-center gap-2.5 group text-muted-foreground hover:text-foreground">
                            <FontAwesomeIcon icon={faInfoCircle} className="w-4 h-4 transition-all duration-300 group-hover:text-primary group-hover:scale-110" />
                            <span className="font-medium">About</span>
                        </Link>
                        <Link to="/contact" className="relative px-4 py-2.5 rounded-lg font-medium text-sm transition-all duration-300 cursor-pointer flex items-center gap-2.5 group text-muted-foreground hover:text-foreground">
                            <FontAwesomeIcon icon={faEnvelope} className="w-4 h-4 transition-all duration-300 group-hover:text-primary group-hover:scale-110" />
                            <span className="font-medium">Contact</span>
                        </Link>
                    </div>

                    # Desktop Actions
                    <div className="hidden md:flex items-center gap-3">
                        <ThemeToggle />
                        <Link to="/auth">
                            <button className="px-6 py-2.5 rounded-lg text-sm font-medium bg-gradient-primary text-white shadow-lg shadow-primary/20 hover:shadow-xl hover:shadow-primary/30 transition-all duration-300 hover:scale-105">
                                Get Started
                            </button>
                        </Link>
                    </div>
                    
                    # Mobile Actions
                    <div className="flex md:hidden items-center gap-2">
                        <ThemeToggle />
                        <button
                            onClick={toggleMenu}
                            className="p-2.5 text-foreground rounded-xl hover:bg-secondary/50 active:bg-secondary transition-colors relative"
                            aria-label="Toggle menu"
                        >
                            {menuIcon}
                        </button>
                    </div>
                </div>
                
                # Mobile Menu
                {menuContent}
            </div>
        </nav>;
    }
    
    # Hero Section - Matching skill-navigator exactly
    def HeroSection() -> any {
        return <section id="hero" className="pt-24 pb-16 sm:pt-32 sm:pb-24 md:pt-40 md:pb-32 relative overflow-hidden min-h-[85vh] sm:min-h-[90vh] flex items-center">
            <div className="absolute inset-0 bg-gradient-hero" />
            <div className="absolute inset-0 bg-gradient-mesh" />
            <div className="absolute top-1/4 left-1/4 w-[500px] h-[500px] bg-primary/5 rounded-full blur-[120px] animate-pulse-slow" />
            <div className="absolute bottom-0 right-1/4 w-[400px] h-[400px] bg-accent/5 rounded-full blur-[100px] animate-pulse-slow" style={{"animationDelay": "1s"}} />
            
            <div className="container mx-auto px-4 sm:px-6 lg:px-8 relative z-10 w-full">
                <div className="grid lg:grid-cols-2 gap-12 lg:gap-20 items-center max-w-7xl mx-auto">
                    <div className="text-center lg:text-left">
                        <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full glass mb-8">
                            <FontAwesomeIcon icon={faMagic} className="w-4 h-4 text-primary" />
                            <span className="text-sm font-medium text-foreground">AI-Powered Career Navigation</span>
                        </div>

                        <h1 className="font-display text-4xl sm:text-5xl md:text-6xl lg:text-7xl xl:text-8xl font-bold text-foreground mb-4 sm:mb-6 md:mb-8 leading-[1.05] tracking-tight">
                            Navigate Your{" "}
                            <span className="text-primary">Career</span>
                            <br />
                            With Clarity
                        </h1>

                        <p className="text-base sm:text-lg md:text-xl text-muted-foreground mb-4 sm:mb-6 max-w-xl mx-auto lg:mx-0 leading-relaxed">
                            AI-powered platform that maps your existing skills to career opportunities and creates personalized learning paths.
                        </p>
                        <p className="text-sm sm:text-base text-muted-foreground mb-8 sm:mb-10 md:mb-12 max-w-xl mx-auto lg:mx-0">
                            Upload your resume, set your goals, and get a clear roadmap to your next role.
                        </p>

                        <div className="flex flex-col sm:flex-row gap-4 md:gap-5 justify-center lg:justify-start">
                            <Link to="/auth">
                                <button className="h-12 sm:h-14 px-8 sm:px-10 text-sm sm:text-base rounded-xl sm:rounded-2xl font-semibold bg-gradient-primary text-white shadow-lg shadow-primary/20 hover:shadow-xl hover:shadow-primary/30 transition-all duration-300 inline-flex items-center justify-center gap-2 w-full sm:w-auto">
                                    <span>Start Free</span>
                                </button>
                            </Link>
                        </div>
                    </div>

                    <div className="hidden lg:block relative w-full h-[500px] flex items-center justify-center">
                        # Background orbs
                        <div className="orb orb-primary w-[300px] h-[300px] top-10 left-10" style={{"animationDelay": "0s"}} />
                        <div className="orb orb-accent w-[200px] h-[200px] bottom-20 right-10" style={{"animationDelay": "-10s"}} />
                        
                        # Grid pattern
                        <div className="absolute inset-0 bg-dots opacity-30" />
                        
                        # Central element (centered at 50% 50% to match SVG line origin)
                        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 z-20">
                            # Outer rotating rings
                            <div className="absolute inset-0 -m-4 rounded-full border border-dashed border-border/60 animate-spin-slow" />
                            <div className="absolute inset-0 -m-12 rounded-full border border-dashed border-border/40" style={{"animationDuration": "40s"}} />
                            
                            # Center orb
                            <div className="relative">
                                <div className="absolute inset-0 bg-gradient-primary rounded-full blur-2xl opacity-40" />
                                <div className="w-28 h-28 rounded-full bg-gradient-primary flex items-center justify-center shadow-glow relative">
                                    <div className="text-center flex flex-col items-center justify-center">
                                        <span className="font-display font-bold text-primary-foreground text-lg">You</span>
                                        <span className="text-primary-foreground/70 text-xs">Start Here</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        # Orbit rings
                        <div className="absolute inset-0 flex items-center justify-center pointer-events-none">
                            <div className="w-[280px] h-[280px] rounded-full border border-border/40" />
                            <div className="absolute w-[400px] h-[400px] rounded-full border border-border/30" />
                        </div>
                        
                        # Skill nodes
                        <div className="absolute z-10" style={{"left": "15%", "top": "20%"}}>
                            <div className="skill-node">Leadership</div>
                        </div>
                        <div className="absolute z-10" style={{"left": "78%", "top": "12%"}}>
                            <div className="skill-node" style={{"animationDelay": "0.2s"}}>Data Analysis</div>
                        </div>
                        <div className="absolute z-10" style={{"left": "8%", "top": "55%"}}>
                            <div className="skill-node" style={{"animationDelay": "0.4s"}}>Strategy</div>
                        </div>
                        <div className="absolute z-10" style={{"left": "82%", "top": "50%"}}>
                            <div className="skill-node" style={{"animationDelay": "0.6s"}}>Communication</div>
                        </div>
                        <div className="absolute z-10" style={{"left": "25%", "top": "80%"}}>
                            <div className="skill-node" style={{"animationDelay": "0.8s"}}>Innovation</div>
                        </div>
                        <div className="absolute z-10" style={{"left": "70%", "top": "78%"}}>
                            <div className="skill-node" style={{"animationDelay": "1s"}}>Design</div>
                        </div>
                        
                        # Connection lines
                        <svg className="absolute inset-0 w-full h-full pointer-events-none z-0" style={{"opacity": "0.6"}}>
                            <defs>
                                <linearGradient id="lineGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                                    <stop offset="0%" stopColor="hsl(var(--primary))" stopOpacity="0.4" />
                                    <stop offset="100%" stopColor="hsl(var(--accent))" stopOpacity="0.4" />
                                </linearGradient>
                            </defs>
                            <line x1="50%" y1="50%" x2="15%" y2="20%" stroke="url(#lineGrad)" strokeWidth="1" strokeDasharray="6 4" />
                            <line x1="50%" y1="50%" x2="78%" y2="12%" stroke="url(#lineGrad)" strokeWidth="1" strokeDasharray="6 4" />
                            <line x1="50%" y1="50%" x2="8%" y2="55%" stroke="url(#lineGrad)" strokeWidth="1" strokeDasharray="6 4" />
                            <line x1="50%" y1="50%" x2="82%" y2="50%" stroke="url(#lineGrad)" strokeWidth="1" strokeDasharray="6 4" />
                            <line x1="50%" y1="50%" x2="25%" y2="80%" stroke="url(#lineGrad)" strokeWidth="1" strokeDasharray="6 4" />
                            <line x1="50%" y1="50%" x2="70%" y2="78%" stroke="url(#lineGrad)" strokeWidth="1" strokeDasharray="6 4" />
                        </svg>
                    </div>
                </div>
            </div>
        </section>;
    }
    
    # Features Section - Showing only 3 features like skill-navigator
    def FeaturesSection() -> any {
        features = [
            {"icon": faFileText, "title": "Resume Intelligence", "desc": "AI extracts your skills, experience, and qualifications into a dynamic skill profile automatically."},
            {"icon": faBullseye, "title": "Career Targeting", "desc": "Define your dream roles and let AI map the fastest path to get there."},
            {"icon": faChartLine, "title": "Gap Analysis", "desc": "Instantly identify missing skills and prioritize what to learn next."}
        ];
        
        return <section id="features" className="py-16 sm:py-20 relative">
            <div className="container mx-auto px-4 sm:px-6 lg:px-8 relative z-10 max-w-5xl">
                <div className="text-center mb-8 sm:mb-12">
                    <h2 className="font-display text-2xl sm:text-3xl md:text-4xl font-bold text-foreground mb-3 sm:mb-4 tracking-tight">
                        What Makes Us <span className="text-primary">Different</span>
                    </h2>
                    <p className="text-sm sm:text-base text-muted-foreground max-w-2xl mx-auto px-4">
                        Three core capabilities that set Skillverse apart.
                    </p>
                </div>

                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-5 md:gap-6 lg:gap-8">
                    {features.map(lambda feature: any -> any {
                        index = features.indexOf(feature);
                        return <div key={index} className="bg-card border border-border/50 rounded-xl p-6 hover:border-primary/20 transition-all duration-300">
                            <div className="flex items-center gap-3 mb-4">
                                <div className="w-12 h-12 rounded-lg bg-primary/10 flex items-center justify-center">
                                    <FontAwesomeIcon icon={feature.icon} className="text-primary text-xl" />
                                </div>
                                <h3 className="text-xl font-semibold text-foreground">{feature.title}</h3>
                            </div>
                            <p className="text-muted-foreground">{feature.desc}</p>
                        </div>;
                    })}
                </div>
            </div>
        </section>;
    }
    
            # How It Works Section - Simplified and Professional
            def HowItWorksSection() -> any {
                steps = [
                    {
                        "icon": faFileText,
                        "title": "Upload Resume",
                        "description": "Upload your resume and let our AI extract your skills, experience, and qualifications automatically."
                    },
                    {
                        "icon": faBullseye,
                        "title": "Set Career Goals",
                        "description": "Define your target roles and career objectives. Our system will analyze the requirements and match them to your profile."
                    },
                    {
                        "icon": faChartLine,
                        "title": "Gap Analysis",
                        "description": "Get instant insights into missing skills and competencies needed for your target roles with prioritized recommendations."
                    },
                    {
                        "icon": faMap,
                        "title": "Get Roadmap",
                        "description": "Receive a personalized learning path with courses, certifications, and projects tailored to bridge your skill gaps."
                    }
                ];
                
                return <section id="demo" className="py-20 md:py-24 relative overflow-hidden">
                    <div className="container mx-auto px-4 sm:px-6 lg:px-8 relative z-10 max-w-6xl">
                        <div className="text-center mb-16 max-w-2xl mx-auto">
                            <h2 className="font-display text-3xl md:text-4xl font-bold text-foreground mb-5 tracking-tight">
                                How It <span className="text-primary">Works</span>
                            </h2>
                            <p className="text-muted-foreground text-base sm:text-lg leading-relaxed">
                                Skillverse uses AI to analyze your background and create personalized career paths. Follow these simple steps to transform your career.
                            </p>
                        </div>

                        <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-6 md:gap-8">
                            {steps.map(lambda step: any -> any {
                                index = steps.indexOf(step);
                                return <div key={index} className="bg-card border border-border/50 rounded-xl p-6 md:p-8 hover:border-primary/30 hover:shadow-lg hover:-translate-y-1 transition-all duration-300 group">
                                    <div className="w-14 h-14 rounded-xl bg-gradient-primary flex items-center justify-center mb-5 shadow-glow group-hover:scale-110 group-hover:shadow-xl group-hover:shadow-primary/40 transition-all duration-300">
                                        <FontAwesomeIcon icon={step.icon} className="w-7 h-7 text-white" />
                                    </div>
                                    <div className="mb-3">
                                        <span className="text-xs font-semibold text-primary uppercase tracking-wide">Step {index + 1}</span>
                                    </div>
                                    <h3 className="font-display font-semibold text-xl sm:text-2xl text-foreground mb-4 group-hover:text-primary transition-colors duration-300">{step.title}</h3>
                                    <p className="text-sm sm:text-base text-muted-foreground leading-relaxed">{step.description}</p>
                                </div>;
                            })}
                        </div>
                    </div>
                </section>;
            }
    
    # About Section - Matching skill-navigator
    def AboutSection() -> any {
        return <section id="about" className="py-20 relative">
            <div className="absolute inset-0 bg-gradient-mesh" />
            <div className="container mx-auto px-4 sm:px-6 lg:px-8 relative z-10 max-w-6xl">
                <div className="grid lg:grid-cols-2 gap-12 items-center">
                    <div className="text-center lg:text-left">
                        <h2 className="font-display text-3xl md:text-4xl font-bold text-foreground mb-6 tracking-tight">
                            About <span className="text-primary">Skillverse</span>
                        </h2>
                        <p className="text-lg text-muted-foreground leading-relaxed mb-4">
                            We're democratizing career intelligence. By combining advanced AI with real-time market data, 
                            we transform complex career decisions into clear, actionable paths.
                        </p>
                        <p className="text-base text-muted-foreground leading-relaxed">
                            Learn more about our mission, values, and team on our dedicated About page.
                        </p>
                        <div className="mt-6">
                            <Link to="/about">
                                <button className="h-12 px-8 rounded-xl border-2 border-border bg-transparent hover:bg-secondary text-foreground hover:border-primary/50 transition-all duration-300 inline-flex items-center gap-2">
                                    <span>Learn More</span>
                                </button>
                            </Link>
                        </div>
                    </div>
                    <div className="hidden lg:block">
                        <img 
                            src="/assets/illustrations/happy.svg" 
                            alt="Happy illustration" 
                            className="w-full h-full object-contain max-w-full"
                            loading="lazy"
                        />
                    </div>
                </div>
            </div>
        </section>;
    }
    
            # Contact Section - Matching skill-navigator
            def ContactSection() -> any {
                return <section id="contact" className="py-20 md:py-24 relative">
                    <div className="container mx-auto px-4 sm:px-6 lg:px-8 relative z-10 max-w-6xl">
                        <div className="grid lg:grid-cols-2 gap-12 lg:gap-16 items-center">
                            <div className="hidden lg:block order-2 lg:order-1">
                                <img 
                                    src="/assets/illustrations/message-sent.svg" 
                                    alt="Message sent illustration" 
                                    className="w-full h-full object-contain max-w-full hover:scale-105 transition-transform duration-500"
                                    loading="lazy"
                                />
                            </div>
                            <div className="text-center lg:text-left order-1 lg:order-2">
                                <h2 className="font-display text-3xl md:text-4xl font-bold text-foreground mb-6 tracking-tight">
                                    Get in <span className="text-primary">Touch</span>
                                </h2>
                                <p className="text-lg sm:text-xl text-muted-foreground leading-relaxed mb-5">
                                    Have questions, feedback, or want to learn more? We're here to help.
                                </p>
                                <p className="text-base sm:text-lg text-muted-foreground leading-relaxed mb-8">
                                    Send us a message through our contact form and we'll get back to you soon.
                                </p>
                                <Link to="/contact">
                                    <button className="h-12 px-8 rounded-xl border-2 border-border bg-transparent hover:bg-secondary text-foreground hover:border-primary/50 hover:scale-105 active:scale-95 transition-all duration-300 inline-flex items-center gap-2 group">
                                        <span>Contact Us</span>
                                    </button>
                                </Link>
                            </div>
                        </div>
                    </div>
                </section>;
            }
    
    # CTA Section - Matching skill-navigator
    def CTASection() -> any {
        return <section id="cta" className="py-24 relative">
            <div className="absolute inset-0 bg-gradient-mesh" />
            <div className="container mx-auto px-4 sm:px-6 lg:px-8 relative z-10 max-w-3xl">
                <div className="text-center">
                    <h2 className="font-display text-3xl md:text-4xl font-bold text-foreground mb-6 tracking-tight">
                        Start Your Career <span className="text-primary">Journey</span>
                    </h2>
                    <p className="text-lg text-muted-foreground mb-10 max-w-xl mx-auto leading-relaxed">
                        Join Skillverse today and get your personalized career roadmap in minutes.
                    </p>
                    
                    <Link to="/auth">
                        <button className="h-14 px-10 text-base rounded-2xl font-semibold bg-gradient-primary text-white shadow-glow hover:opacity-90 transition-all duration-300 inline-flex items-center gap-2">
                            <span>Get Started Free</span>
                        </button>
                    </Link>
                </div>
            </div>
        </section>;
    }
    
    # Footer Component
    def Footer() -> any {
        currentYear = 2025;
        
        return <footer className="relative border-t border-border/50 bg-background">
            <div className="container mx-auto px-4 sm:px-6 lg:px-8 py-12 md:py-16">
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 lg:gap-12 mb-12">
                    # Brand Section
                    <div className="lg:col-span-1">
                        <Link to="/" className="inline-block mb-4 group">
                            <div className="relative">
                                <img 
                                    src="/assets/illustrations/logo.png" 
                                    alt="Skillverse Logo" 
                                    className="w-32 h-32 sm:w-36 sm:h-36 md:w-40 md:h-40 object-contain group-hover:opacity-90 transition-opacity duration-300"
                                />
                            </div>
                        </Link>
                        <p className="text-sm text-muted-foreground leading-relaxed max-w-xs">
                            AI-powered career navigation that transforms how you discover, learn, and grow.
                        </p>
                    </div>

                    # Product Links
                    <div>
                        <h4 className="font-display font-semibold text-foreground mb-4 text-sm">
                            Product
                        </h4>
                        <ul className="space-y-2.5">
                            <li>
                                <Link
                                    to="/#features"
                                    className="text-sm text-muted-foreground hover:text-foreground transition-all duration-300 relative group inline-block"
                                >
                                    <span className="relative z-10">Features</span>
                                    <span className="absolute bottom-0 left-0 w-0 h-0.5 bg-primary transition-all duration-300 group-hover:w-full"></span>
                                </Link>
                            </li>
                            <li>
                                <Link
                                    to="/#demo"
                                    className="text-sm text-muted-foreground hover:text-foreground transition-all duration-300 relative group inline-block"
                                >
                                    <span className="relative z-10">How It Works</span>
                                    <span className="absolute bottom-0 left-0 w-0 h-0.5 bg-primary transition-all duration-300 group-hover:w-full"></span>
                                </Link>
                            </li>
                        </ul>
                    </div>

                    # Company Links
                    <div>
                        <h4 className="font-display font-semibold text-foreground mb-4 text-sm">
                            Company
                        </h4>
                        <ul className="space-y-2.5">
                            <li>
                                <Link
                                    to="/about"
                                    className="text-sm text-muted-foreground hover:text-foreground transition-all duration-300 relative group inline-block"
                                >
                                    <span className="relative z-10">About</span>
                                    <span className="absolute bottom-0 left-0 w-0 h-0.5 bg-primary transition-all duration-300 group-hover:w-full"></span>
                                </Link>
                            </li>
                            <li>
                                <Link
                                    to="/contact"
                                    className="text-sm text-muted-foreground hover:text-foreground transition-all duration-300 relative group inline-block"
                                >
                                    <span className="relative z-10">Contact</span>
                                    <span className="absolute bottom-0 left-0 w-0 h-0.5 bg-primary transition-all duration-300 group-hover:w-full"></span>
                                </Link>
                            </li>
                        </ul>
                    </div>

                    # Legal Links
                    <div>
                        <h4 className="font-display font-semibold text-foreground mb-4 text-sm">
                            Legal
                        </h4>
                        <ul className="space-y-2.5">
                            <li>
                                <a
                                    href="#"
                                    className="text-sm text-muted-foreground hover:text-foreground transition-all duration-300 relative group inline-block"
                                >
                                    <span className="relative z-10">Privacy Policy</span>
                                    <span className="absolute bottom-0 left-0 w-0 h-0.5 bg-primary transition-all duration-300 group-hover:w-full"></span>
                                </a>
                            </li>
                            <li>
                                <a
                                    href="#"
                                    className="text-sm text-muted-foreground hover:text-foreground transition-all duration-300 relative group inline-block"
                                >
                                    <span className="relative z-10">Terms of Service</span>
                                    <span className="absolute bottom-0 left-0 w-0 h-0.5 bg-primary transition-all duration-300 group-hover:w-full"></span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>

                # Bottom Bar
                <div className="border-t border-border/50 pt-8">
                    <p className="text-sm text-muted-foreground text-center">
                        © {currentYear} Skillverse. All rights reserved.
                    </p>
                </div>
            </div>
        </footer>;
    }
    
        # About Page - Full Implementation
    def AboutPage() -> any {
        return <div className="min-h-screen bg-background overflow-hidden">
            <Navbar />
            
            # Hero Section
            <section className="pt-28 pb-24 sm:pt-32 sm:pb-24 md:pt-36 md:pb-24 relative">
                <div className="absolute inset-0 bg-gradient-hero" />
                <div className="absolute inset-0 bg-gradient-mesh" />
                <div className="absolute top-1/3 right-1/4 w-[400px] h-[400px] bg-accent/10 rounded-full blur-[100px]" />
                
                <div className="container mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
                    <div className="grid lg:grid-cols-2 gap-12 items-center max-w-6xl mx-auto">
                        <div className="text-center lg:text-left">
                            <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full glass mb-8">
                                <FontAwesomeIcon icon={faBolt} className="w-4 h-4 text-primary" />
                                <span className="text-sm font-medium text-foreground">About Skillverse</span>
                            </div>
                            
                            <h1 className="font-display text-5xl md:text-6xl font-bold text-foreground mb-6">
                                About <span className="text-gradient">Skillverse</span>
                            </h1>
                            <p className="text-lg md:text-xl text-muted-foreground leading-relaxed mb-4">
                                We're building the compass for your professional journey—powered by AI, 
                                driven by your ambitions.
                            </p>
                            <p className="text-base text-muted-foreground leading-relaxed">
                                Learn how we're transforming career navigation through intelligent technology and real-time market insights.
                            </p>
                        </div>
                        
                        <div className="hidden lg:block">
                            <img 
                                src="/assets/illustrations/team.svg" 
                                alt="Team illustration" 
                                className="w-full h-full object-contain max-w-full"
                                loading="lazy"
                            />
                        </div>
                    </div>
                </div>
            </section>
            
            # Problem & Solution Section
            <section className="py-20 relative">
                <div className="absolute inset-0 bg-gradient-mesh opacity-50" />
                
                <div className="container mx-auto px-4 sm:px-6 lg:px-8 relative z-10 max-w-6xl">
                    <div className="grid lg:grid-cols-2 gap-12 lg:gap-16 items-start mb-16">
                        <div>
                            <h2 className="font-display text-3xl md:text-4xl font-bold text-foreground mb-5">
                                The <span className="text-gradient">Problem</span>
                            </h2>
                            <p className="text-muted-foreground mb-5 leading-relaxed">
                                Career navigation is complex and overwhelming. Professionals struggle to:
                            </p>
                            <ul className="space-y-3 text-muted-foreground">
                                <li className="flex items-start gap-3">
                                    <span className="text-primary mt-1.5 font-bold">•</span>
                                    <span>Identify which skills are in demand for their target roles</span>
                                </li>
                                <li className="flex items-start gap-3">
                                    <span className="text-primary mt-1.5 font-bold">•</span>
                                    <span>Understand the gap between their current skills and career goals</span>
                                </li>
                                <li className="flex items-start gap-3">
                                    <span className="text-primary mt-1.5 font-bold">•</span>
                                    <span>Find the most efficient learning path to bridge that gap</span>
                                </li>
                                <li className="flex items-start gap-3">
                                    <span className="text-primary mt-1.5 font-bold">•</span>
                                    <span>Keep up with rapidly changing job market demands</span>
                                </li>
                            </ul>
                        </div>
                        
                        <div>
                            <h2 className="font-display text-3xl md:text-4xl font-bold text-foreground mb-5">
                                Our <span className="text-gradient">Solution</span>
                            </h2>
                            <p className="text-muted-foreground mb-5 leading-relaxed">
                                Skillverse uses AI and real-time market intelligence to:
                            </p>
                            <ul className="space-y-3 text-muted-foreground">
                                <li className="flex items-start gap-3">
                                    <span className="text-primary mt-1.5 font-bold">•</span>
                                    <span>Automatically extract and map your skills from your resume</span>
                                </li>
                                <li className="flex items-start gap-3">
                                    <span className="text-primary mt-1.5 font-bold">•</span>
                                    <span>Compare your profile against target roles and market demand</span>
                                </li>
                                <li className="flex items-start gap-3">
                                    <span className="text-primary mt-1.5 font-bold">•</span>
                                    <span>Generate personalized learning roadmaps with courses and certifications</span>
                                </li>
                                <li className="flex items-start gap-3">
                                    <span className="text-primary mt-1.5 font-bold">•</span>
                                    <span>Continuously adapt recommendations as market trends evolve</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    
                    # Mission Section
                    <div className="text-center max-w-3xl mx-auto p-8 rounded-3xl glass border border-border/50">
                        <h2 className="font-display text-3xl md:text-4xl font-bold text-foreground mb-5">
                            Our <span className="text-gradient">Mission</span>
                        </h2>
                        <p className="text-muted-foreground mb-4 leading-relaxed">
                            We're democratizing career intelligence. In a rapidly evolving job market, 
                            everyone deserves access to insights that shape their future.
                        </p>
                        <p className="text-muted-foreground leading-relaxed mb-6">
                            By combining advanced AI with real-time market data, we transform complex 
                            career decisions into clear, actionable paths.
                        </p>
                        <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full glass border border-primary/20 mt-4">
                            <FontAwesomeIcon icon={faCode} className="w-4 h-4 text-primary" />
                            <span className="text-sm font-medium text-foreground">
                                Powered by <span className="text-primary font-semibold">Jac Fullstack</span>
                            </span>
                        </div>
                    </div>
                </div>
            </section>
            
            # Values Section
            <section className="py-20 relative">
                <div className="absolute inset-0 bg-gradient-mesh opacity-50" />
                
                <div className="container mx-auto px-4 sm:px-6 lg:px-8 relative z-10 max-w-6xl">
                    <div className="text-center mb-12">
                        <h2 className="font-display text-3xl md:text-4xl font-bold text-foreground mb-4">
                            Our <span className="text-gradient">Values</span>
                        </h2>
                        <p className="text-muted-foreground max-w-2xl mx-auto">
                            The principles that guide everything we build.
                        </p>
                    </div>
                    
                    <div className="grid md:grid-cols-3 gap-6">
                        <div className="flex flex-col items-center text-center p-8 rounded-2xl glass border border-border/50 hover:border-primary/20 transition-all duration-300">
                            <div className="w-16 h-16 rounded-xl bg-gradient-primary flex items-center justify-center mb-5 shadow-glow">
                                <FontAwesomeIcon icon={faBullseye} className="w-8 h-8 text-white" />
                            </div>
                            <h3 className="font-display font-semibold text-lg text-foreground mb-3">
                                Precision
                            </h3>
                            <p className="text-muted-foreground text-sm leading-relaxed">
                                Data-driven guidance tailored to your unique journey.
                            </p>
                        </div>
                        <div className="flex flex-col items-center text-center p-8 rounded-2xl glass border border-border/50 hover:border-primary/20 transition-all duration-300">
                            <div className="w-16 h-16 rounded-xl bg-gradient-primary flex items-center justify-center mb-5 shadow-glow">
                                <FontAwesomeIcon icon={faHeart} className="w-8 h-8 text-white" />
                            </div>
                            <h3 className="font-display font-semibold text-lg text-foreground mb-3">
                                Accessibility
                            </h3>
                            <p className="text-muted-foreground text-sm leading-relaxed">
                                Career intelligence for everyone, in any industry.
                            </p>
                        </div>
                        <div className="flex flex-col items-center text-center p-8 rounded-2xl glass border border-border/50 hover:border-primary/20 transition-all duration-300">
                            <div className="w-16 h-16 rounded-xl bg-gradient-primary flex items-center justify-center mb-5 shadow-glow">
                                <FontAwesomeIcon icon={faLightbulb} className="w-8 h-8 text-white" />
                            </div>
                            <h3 className="font-display font-semibold text-lg text-foreground mb-3">
                                Innovation
                            </h3>
                            <p className="text-muted-foreground text-sm leading-relaxed">
                                AI that evolves with the changing job market.
                            </p>
                        </div>
                    </div>
                </div>
            </section>
            
            # Hackathon Badge Section
            <section className="py-12 relative">
                <div className="container mx-auto px-4 relative z-10 max-w-4xl">
                    <div className="text-center">
                        <div className="inline-flex items-center gap-2 sm:gap-3 px-4 sm:px-6 py-2 sm:py-3 rounded-full glass border border-primary/20 mb-4 sm:mb-6">
                            <FontAwesomeIcon icon={faRocket} className="w-4 h-4 sm:w-5 sm:h-5 text-primary" />
                            <span className="text-xs sm:text-sm font-semibold text-foreground">Hackathon Project 2025</span>
                            <FontAwesomeIcon icon={faTrophy} className="w-4 h-4 sm:w-5 sm:h-5 text-primary" />
                        </div>
                        <p className="text-muted-foreground text-xs sm:text-sm max-w-2xl mx-auto px-4 mb-4">
                            Built in 3 weeks by a passionate team from Nairobi, Kenya. 
                            Combining AI, real-time data, and modern design to solve career navigation challenges.
                        </p>
                        <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full glass border border-primary/20">
                            <FontAwesomeIcon icon={faCode} className="w-4 h-4 text-primary" />
                            <span className="text-xs sm:text-sm font-medium text-foreground">
                                Built with <span className="text-primary font-semibold">Jac Fullstack</span>
                            </span>
                        </div>
                    </div>
                </div>
            </section>
            
            # Team Section
            <section className="py-20 relative">
                <div className="absolute inset-0 bg-gradient-mesh opacity-30" />
                
                <div className="container mx-auto px-4 relative z-10 max-w-7xl">
                    <div className="text-center mb-16">
                        <div className="inline-flex items-center gap-2 mb-4 flex-wrap justify-center">
                            <FontAwesomeIcon icon={faMagic} className="w-4 h-4 sm:w-5 sm:h-5 text-primary" />
                            <h2 className="font-display text-3xl sm:text-4xl md:text-5xl font-bold text-foreground">
                                Meet the <span className="text-gradient">Team</span>
                            </h2>
                            <FontAwesomeIcon icon={faMagic} className="w-4 h-4 sm:w-5 sm:h-5 text-primary" />
                        </div>
                        <p className="text-muted-foreground text-base sm:text-lg max-w-2xl mx-auto px-4">
                            Three developers, one vision: democratizing career intelligence through AI-powered navigation.
                        </p>
                    </div>
                    
                    # Team Leader - Denis (Featured)
                    <div className="mb-12 max-w-4xl mx-auto">
                        <div className="group relative p-6 sm:p-8 md:p-10 rounded-2xl sm:rounded-3xl glass-strong border-2 border-primary/30 hover:border-primary/50 transition-all duration-300 overflow-hidden">
                            <div className="absolute top-4 right-4 sm:top-6 sm:right-6 z-20">
                                <div className="flex items-center gap-1.5 sm:gap-2 px-3 sm:px-4 py-1.5 sm:py-2 rounded-full bg-gradient-primary shadow-lg">
                                    <FontAwesomeIcon icon={faCrown} className="w-3 h-3 sm:w-4 sm:h-4 text-white" />
                                    <span className="text-[10px] sm:text-xs font-bold text-white">Team Leader</span>
                                </div>
                            </div>
                            
                            <div className="flex flex-col sm:grid sm:grid-cols-[auto_1fr] gap-6 sm:gap-8 items-center relative z-10">
                                <div className="relative">
                                    <div className="relative w-24 h-24 sm:w-32 sm:h-32 md:w-36 md:h-36 rounded-2xl sm:rounded-3xl bg-gradient-to-br from-primary to-primary/80 flex items-center justify-center shadow-2xl shadow-primary/30 group-hover:shadow-primary/50 transition-all duration-300 overflow-hidden">
                                        <img 
                                            src="/assets/illustrations/denis-team-lead.svg" 
                                            alt="Denis Mwanzia"
                                            className="w-full h-full object-cover relative z-10"
                                        />
                                    </div>
                                </div>
                                
                                <div className="text-center sm:text-left w-full">
                                    <h3 className="font-display font-bold text-xl sm:text-2xl md:text-3xl text-foreground mb-2 group-hover:text-primary transition-colors">
                                        Denis Mwanzia
                                    </h3>
                                    <p className="text-primary text-sm sm:text-base font-semibold mb-3">Team Leader & Full-Stack Developer</p>
                                    <p className="text-sm sm:text-base text-muted-foreground leading-relaxed mb-4">
                                        Leading the vision and building the core platform. Passionate about AI and creating solutions that make a real impact.
                                    </p>
                                    <p className="text-xs sm:text-sm text-muted-foreground italic mb-4 sm:mb-5">
                                        Architected the platform and led the team through the hackathon journey
                                    </p>
                                    
                                    <div className="flex flex-wrap gap-2 justify-center sm:justify-start mb-4 sm:mb-5">
                                        <span className="text-[10px] sm:text-xs px-2 py-0.5 rounded-full border border-border/50 bg-secondary/50 text-foreground">
                                            Leadership
                                        </span>
                                        <span className="text-[10px] sm:text-xs px-2 py-0.5 rounded-full border border-border/50 bg-secondary/50 text-foreground">
                                            Full-Stack
                                        </span>
                                        <span className="text-[10px] sm:text-xs px-2 py-0.5 rounded-full border border-border/50 bg-secondary/50 text-foreground">
                                            AI Integration
                                        </span>
                                    </div>
                                    
                                    <div className="flex gap-2 justify-center sm:justify-start">
                                        <a href="#" className="w-9 h-9 sm:w-10 sm:h-10 rounded-xl glass flex items-center justify-center text-muted-foreground hover:text-primary hover:bg-primary/10 transition-all duration-300">
                                            <FontAwesomeIcon icon={faXTwitter} className="w-4 h-4" />
                                        </a>
                                        <a href="#" className="w-9 h-9 sm:w-10 sm:h-10 rounded-xl glass flex items-center justify-center text-muted-foreground hover:text-primary hover:bg-primary/10 transition-all duration-300">
                                            <FontAwesomeIcon icon={faLinkedin} className="w-4 h-4" />
                                        </a>
                                        <a href="#" className="w-9 h-9 sm:w-10 sm:h-10 rounded-xl glass flex items-center justify-center text-muted-foreground hover:text-primary hover:bg-primary/10 transition-all duration-300">
                                            <FontAwesomeIcon icon={faGithub} className="w-4 h-4" />
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    # Other Team Members
                    <div className="grid md:grid-cols-2 gap-6 lg:gap-8 max-w-5xl mx-auto">
                        <div className="group relative p-6 sm:p-8 rounded-2xl glass-strong border border-border/50 hover:border-primary/30 hover:shadow-xl hover:-translate-y-1 transition-all duration-300 overflow-hidden">
                            <div className="relative z-10">
                                <div className="relative inline-block mb-6">
                                    <div className="relative w-28 h-28 sm:w-32 sm:h-32 rounded-2xl bg-gradient-to-br from-accent to-accent/80 flex items-center justify-center shadow-lg shadow-primary/20 group-hover:shadow-xl group-hover:shadow-primary/30 group-hover:scale-105 transition-all duration-300 overflow-hidden">
                                        <img 
                                            src="/assets/illustrations/doris.svg" 
                                            alt="Doris Muasya"
                                            className="w-full h-full object-cover relative z-10"
                                        />
                                    </div>
                                    <div className="absolute -bottom-1 -right-1 w-7 h-7 rounded-full bg-accent flex items-center justify-center border-2 border-background shadow-lg group-hover:scale-110 transition-transform duration-300">
                                        <span className="text-xs text-white">♀</span>
                                    </div>
                                </div>
                                
                                <h3 className="font-display font-bold text-xl sm:text-2xl text-foreground mb-2 group-hover:text-primary transition-colors">
                                    Doris Muasya
                                </h3>
                                <p className="text-primary text-sm sm:text-base font-semibold mb-4">Product Designer & Frontend Developer</p>
                                <p className="text-sm sm:text-base text-muted-foreground leading-relaxed mb-4">
                                    Crafting beautiful, intuitive experiences. Ensures every interaction feels seamless and empowering.
                                </p>
                                <p className="text-xs sm:text-sm text-muted-foreground italic mb-5">
                                    Designed the entire user experience and built the stunning frontend
                                </p>
                                
                                <div className="flex flex-wrap gap-2 mb-5">
                                    <span className="text-xs sm:text-sm px-3 py-1 rounded-full border border-border/50 bg-secondary/50 text-foreground hover:bg-primary/10 hover:border-primary/50 transition-all duration-300">
                                        UI/UX Design
                                    </span>
                                    <span className="text-xs sm:text-sm px-3 py-1 rounded-full border border-border/50 bg-secondary/50 text-foreground hover:bg-primary/10 hover:border-primary/50 transition-all duration-300">
                                        Frontend
                                    </span>
                                    <span className="text-xs sm:text-sm px-3 py-1 rounded-full border border-border/50 bg-secondary/50 text-foreground hover:bg-primary/10 hover:border-primary/50 transition-all duration-300">
                                        User Research
                                    </span>
                                </div>
                                
                                <div className="flex gap-3">
                                    <a href="#" className="w-10 h-10 sm:w-11 sm:h-11 rounded-xl glass flex items-center justify-center text-muted-foreground hover:text-primary hover:bg-primary/10 hover:scale-110 transition-all duration-300">
                                        <FontAwesomeIcon icon={faXTwitter} className="w-4 h-4 sm:w-5 sm:h-5" />
                                    </a>
                                    <a href="#" className="w-10 h-10 sm:w-11 sm:h-11 rounded-xl glass flex items-center justify-center text-muted-foreground hover:text-primary hover:bg-primary/10 hover:scale-110 transition-all duration-300">
                                        <FontAwesomeIcon icon={faLinkedin} className="w-4 h-4 sm:w-5 sm:h-5" />
                                    </a>
                                    <a href="#" className="w-10 h-10 sm:w-11 sm:h-11 rounded-xl glass flex items-center justify-center text-muted-foreground hover:text-primary hover:bg-primary/10 hover:scale-110 transition-all duration-300">
                                        <FontAwesomeIcon icon={faGithub} className="w-4 h-4 sm:w-5 sm:h-5" />
                                    </a>
                                </div>
                            </div>
                        </div>
                        
                        <div className="group relative p-6 sm:p-8 rounded-2xl glass-strong border border-border/50 hover:border-primary/30 hover:shadow-xl hover:-translate-y-1 transition-all duration-300 overflow-hidden">
                            <div className="relative z-10">
                                <div className="relative inline-block mb-6">
                                    <div className="relative w-28 h-28 sm:w-32 sm:h-32 rounded-2xl bg-gradient-to-br from-primary/80 to-accent/80 flex items-center justify-center shadow-lg shadow-primary/20 group-hover:shadow-xl group-hover:shadow-primary/30 group-hover:scale-105 transition-all duration-300 overflow-hidden">
                                        <img 
                                            src="/assets/illustrations/james.svg" 
                                            alt="James Ngaruiya"
                                            className="w-full h-full object-cover relative z-10"
                                        />
                                    </div>
                                </div>
                                
                                <h3 className="font-display font-bold text-xl sm:text-2xl text-foreground mb-2 group-hover:text-primary transition-colors">
                                    James Ngaruiya
                                </h3>
                                <p className="text-primary text-sm sm:text-base font-semibold mb-4">AI Engineer & Backend Developer</p>
                                <p className="text-sm sm:text-base text-muted-foreground leading-relaxed mb-4">
                                    Building intelligent systems that power our AI. Focused on making complex technology simple and accessible.
                                </p>
                                <p className="text-xs sm:text-sm text-muted-foreground italic mb-5">
                                    Developed the AI engine and backend infrastructure
                                </p>
                                
                                <div className="flex flex-wrap gap-2 mb-5">
                                    <span className="text-xs sm:text-sm px-3 py-1 rounded-full border border-border/50 bg-secondary/50 text-foreground hover:bg-primary/10 hover:border-primary/50 transition-all duration-300">
                                        AI/ML
                                    </span>
                                    <span className="text-xs sm:text-sm px-3 py-1 rounded-full border border-border/50 bg-secondary/50 text-foreground hover:bg-primary/10 hover:border-primary/50 transition-all duration-300">
                                        Backend
                                    </span>
                                    <span className="text-xs sm:text-sm px-3 py-1 rounded-full border border-border/50 bg-secondary/50 text-foreground hover:bg-primary/10 hover:border-primary/50 transition-all duration-300">
                                        Data Engineering
                                    </span>
                                </div>
                                
                                <div className="flex gap-3">
                                    <a href="#" className="w-10 h-10 sm:w-11 sm:h-11 rounded-xl glass flex items-center justify-center text-muted-foreground hover:text-primary hover:bg-primary/10 hover:scale-110 transition-all duration-300">
                                        <FontAwesomeIcon icon={faXTwitter} className="w-4 h-4 sm:w-5 sm:h-5" />
                                    </a>
                                    <a href="#" className="w-10 h-10 sm:w-11 sm:h-11 rounded-xl glass flex items-center justify-center text-muted-foreground hover:text-primary hover:bg-primary/10 hover:scale-110 transition-all duration-300">
                                        <FontAwesomeIcon icon={faLinkedin} className="w-4 h-4 sm:w-5 sm:h-5" />
                                    </a>
                                    <a href="#" className="w-10 h-10 sm:w-11 sm:h-11 rounded-xl glass flex items-center justify-center text-muted-foreground hover:text-primary hover:bg-primary/10 hover:scale-110 transition-all duration-300">
                                        <FontAwesomeIcon icon={faGithub} className="w-4 h-4 sm:w-5 sm:h-5" />
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    # Hackathon Stats
                    <div className="mt-16 max-w-4xl mx-auto">
                        <div className="grid grid-cols-3 gap-2 sm:gap-4 p-4 sm:p-6 rounded-xl sm:rounded-2xl glass border border-border/50">
                            <div className="text-center">
                                <div className="flex items-center justify-center gap-1 sm:gap-2 mb-1 sm:mb-2">
                                    <FontAwesomeIcon icon={faClock} className="w-4 h-4 sm:w-5 sm:h-5 text-primary" />
                                    <span className="font-display font-bold text-lg sm:text-2xl text-foreground">3 weeks</span>
                                </div>
                                <p className="text-[10px] sm:text-xs text-muted-foreground">Build Time</p>
                            </div>
                            <div className="text-center">
                                <div className="flex items-center justify-center gap-1 sm:gap-2 mb-1 sm:mb-2">
                                    <FontAwesomeIcon icon={faCode} className="w-4 h-4 sm:w-5 sm:h-5 text-primary" />
                                    <span className="font-display font-bold text-lg sm:text-2xl text-foreground">3</span>
                                </div>
                                <p className="text-[10px] sm:text-xs text-muted-foreground">Developers</p>
                            </div>
                            <div className="text-center">
                                <div className="flex items-center justify-center gap-1 sm:gap-2 mb-1 sm:mb-2">
                                    <FontAwesomeIcon icon={faAward} className="w-4 h-4 sm:w-5 sm:h-5 text-primary" />
                                    <span className="font-display font-bold text-lg sm:text-2xl text-foreground">100%</span>
                                </div>
                                <p className="text-[10px] sm:text-xs text-muted-foreground">Passion</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            
            <Footer />
        </div>;
    }
    
    def ContactPage() -> any {
        return <div className="min-h-screen bg-background overflow-hidden">
            <Navbar />
            
            # Hero Section
            <section className="pt-28 pb-16 sm:pt-32 sm:pb-16 md:pt-36 md:pb-16 relative">
                <div className="absolute inset-0 bg-gradient-hero" />
                <div className="absolute inset-0 bg-gradient-mesh" />
                <div className="absolute top-1/3 left-1/4 w-[400px] h-[400px] bg-primary/10 rounded-full blur-[100px]" />
                
                <div className="container mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
                    <div className="max-w-2xl mx-auto text-center">
                        <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full glass mb-8">
                            <FontAwesomeIcon icon={faBolt} className="w-4 h-4 text-primary" />
                            <span className="text-sm font-medium text-foreground">Get in Touch</span>
                        </div>
                        
                        <h1 className="font-display text-4xl sm:text-5xl md:text-6xl font-bold text-foreground mb-4 sm:mb-6">
                            Get in <span className="text-gradient">Touch</span>
                        </h1>
                        <p className="text-base sm:text-lg md:text-xl text-muted-foreground max-w-2xl mx-auto px-4">
                            Have questions, feedback, or want to learn more? We're here to help. Send us a message and we'll get back to you soon.
                        </p>
                    </div>
                </div>
            </section>
            
            # Contact Section
            <section className="py-20 relative">
                <div className="absolute inset-0 bg-gradient-mesh" />
                
                <div className="container mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
                    <div className="grid lg:grid-cols-5 gap-8 lg:gap-12 max-w-6xl mx-auto">
                        # Contact Info
                        <div className="lg:col-span-2 order-2 lg:order-1">
                            # Illustration - Hidden on mobile, shown on desktop
                            <div className="hidden lg:block mb-8">
                                <img 
                                    src="/assets/illustrations/message-sent.svg" 
                                    alt="Message sent illustration" 
                                    className="max-w-full h-40 sm:h-48 object-contain"
                                    loading="lazy"
                                />
                            </div>
                            <h2 className="font-display text-2xl font-bold text-foreground mb-4">
                                Contact <span className="text-gradient">Information</span>
                            </h2>
                            <p className="text-sm text-muted-foreground mb-8 leading-relaxed">
                                Reach out via email or use the form to send us a message.
                            </p>
                            
                            <div className="space-y-4">
                                # Email
                                <div className="flex items-start gap-4 p-5 rounded-2xl glass border border-border/50 hover:border-primary/20 transition-all duration-300">
                                    <div className="w-11 h-11 rounded-xl bg-gradient-primary flex items-center justify-center flex-shrink-0 shadow-glow">
                                        <FontAwesomeIcon icon={faEnvelope} className="w-5 h-5 text-white" />
                                    </div>
                                    <div className="min-w-0 flex-1">
                                        <h3 className="font-display font-medium text-foreground text-sm mb-0.5">
                                            Email
                                        </h3>
                                        <a href="mailto:denismwanzia56@gmail.com" className="text-muted-foreground hover:text-primary transition-colors text-sm break-all">
                                            denismwanzia56@gmail.com
                                        </a>
                                    </div>
                                </div>
                                
                                # Location
                                <div className="flex items-start gap-4 p-5 rounded-2xl glass border border-border/50 hover:border-primary/20 transition-all duration-300">
                                    <div className="w-11 h-11 rounded-xl bg-gradient-primary flex items-center justify-center flex-shrink-0 shadow-glow">
                                        <FontAwesomeIcon icon={faMap} className="w-5 h-5 text-white" />
                                    </div>
                                    <div className="min-w-0 flex-1">
                                        <h3 className="font-display font-medium text-foreground text-sm mb-0.5">
                                            Location
                                        </h3>
                                        <p className="text-muted-foreground text-sm">Nairobi, Kenya</p>
                                    </div>
                                </div>
                                
                                # Support
                                <div className="flex items-start gap-4 p-5 rounded-2xl glass border border-border/50 hover:border-primary/20 transition-all duration-300">
                                    <div className="w-11 h-11 rounded-xl bg-gradient-primary flex items-center justify-center flex-shrink-0 shadow-glow">
                                        <FontAwesomeIcon icon={faEnvelope} className="w-5 h-5 text-white" />
                                    </div>
                                    <div className="min-w-0 flex-1">
                                        <h3 className="font-display font-medium text-foreground text-sm mb-0.5">
                                            Support
                                        </h3>
                                        <a href="mailto:denismwanzia56@gmail.com" className="text-muted-foreground hover:text-primary transition-colors text-sm break-all">
                                            denismwanzia56@gmail.com
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        # Contact Form
                        <div className="lg:col-span-3 order-1 lg:order-2">
                            <form className="p-8 lg:p-10 rounded-3xl glass-strong border border-border/50">
                                <h2 className="font-display text-2xl font-bold text-foreground mb-2">
                                    Send Us a Message
                                </h2>
                                <p className="text-sm text-muted-foreground mb-8">
                                    Fill out the form below and we'll respond as soon as possible.
                                </p>
                                
                                <div className="grid grid-cols-1 sm:grid-cols-2 gap-5 mb-5">
                                    <div>
                                        <label className="block text-sm font-medium text-foreground mb-2.5">
                                            Name
                                        </label>
                                        <input
                                            type="text"
                                            placeholder="Your name"
                                            required
                                            className="w-full h-12 px-4 text-base rounded-xl bg-background/50 border border-border/50 text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-primary/50 transition-all duration-300"
                                        />
                                    </div>
                                    <div>
                                        <label className="block text-sm font-medium text-foreground mb-2.5">
                                            Email
                                        </label>
                                        <input
                                            type="email"
                                            placeholder="you@example.com"
                                            required
                                            className="w-full h-12 px-4 text-base rounded-xl bg-background/50 border border-border/50 text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-primary/50 transition-all duration-300"
                                        />
                                    </div>
                                </div>
                                
                                <div className="mb-5">
                                    <label className="block text-sm font-medium text-foreground mb-2.5">
                                        Subject
                                    </label>
                                    <input
                                        type="text"
                                        placeholder="How can we help?"
                                        required
                                        className="w-full h-12 px-4 text-base rounded-xl bg-background/50 border border-border/50 text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-primary/50 transition-all duration-300"
                                    />
                                </div>
                                
                                <div className="mb-8">
                                    <label className="block text-sm font-medium text-foreground mb-2.5">
                                        Message
                                    </label>
                                    <textarea
                                        placeholder="Tell us more..."
                                        required
                                        rows={5}
                                        className="w-full px-6 py-5 text-lg rounded-xl bg-background/50 border border-border/50 text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-primary/50 transition-all duration-300 resize-none"
                                    />
                                </div>
                                
                                <button
                                    type="submit"
                                    className="w-full h-14 px-6 rounded-2xl font-semibold bg-gradient-primary text-white shadow-glow hover:opacity-90 transition-all duration-300 inline-flex items-center justify-center gap-2 text-base"
                                >
                                    <span>Send Message</span>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </section>
            
            <Footer />
        </div>;
    }
    
    # Auth utility functions (all in Jac, backed by runtime auth API)
    def AuthPage() -> any {
        # State management
        navigate = useNavigate();
        isLoading = useState(false);
        errorMessage = useState("");
        successMessage = useState("");
        
        # Form state for login
        loginEmail = useState("");
        loginPassword = useState("");
        
        # Form state for signup
        signupName = useState("");
        signupEmail = useState("");
        signupPassword = useState("");
        
        # Handle login form submission (uses @jac/runtime backend auth)
        async def handleLoginSubmit(e: any) -> None {
            e.preventDefault();
            isLoading[1](true);
            errorMessage[1]("");
            successMessage[1]("");
            
            # Basic validation
            if not loginEmail[0] or not loginPassword[0] {
                errorMessage[1]("Please fill in all fields");
                isLoading[1](false);
                return;
            }
            
            try {
                # jacLogin talks to /user/login on the Jac API server
                success = await jacLogin(loginEmail[0], loginPassword[0]);
                if success {
                    successMessage[1]("Login successful! Redirecting...");
                    navigate("/dashboard");
                } else {
                    errorMessage[1]("Invalid credentials");
                }
            } except Exception as err {
                console.error("Login error:", err);
                errorMessage[1]("Login failed. Please try again.");
            } finally {
                isLoading[1](false);
            }
        }
        
        # Handle signup form submission (uses @jac/runtime backend auth)
        async def handleSignupSubmit(e: any) -> None {
            e.preventDefault();
            isLoading[1](true);
            errorMessage[1]("");
            successMessage[1]("");
            
            # Basic validation
            if not signupEmail[0] or not signupPassword[0] {
                errorMessage[1]("Please fill in all fields");
                isLoading[1](false);
                return;
            }
            if signupPassword[0].length < 6 {
                errorMessage[1]("Password must be at least 6 characters");
                isLoading[1](false);
                return;
            }
            
            try {
                # Use email as username for built-in auth
                result = await jacSignup(signupEmail[0], signupPassword[0]);
                is_success = result["success"] if "success" in result else false;
                if is_success {
                    successMessage[1]("Account created successfully! Redirecting...");
                    navigate("/dashboard");
                } else {
                    error_text = result["error"] if "error" in result else "Signup failed";
                    errorMessage[1](error_text);
                }
            } except Exception as err {
                console.error("Signup error:", err);
                errorMessage[1]("Signup failed. Please try again.");
            } finally {
                isLoading[1](false);
            }
        }
        
        # Form input handlers
        def handleLoginEmailChange(e: any) -> None {
            loginEmail[1](e.target.value);
        }
        
        def handleLoginPasswordChange(e: any) -> None {
            loginPassword[1](e.target.value);
        }
        
        def handleSignupNameChange(e: any) -> None {
            signupName[1](e.target.value);
        }
        
        def handleSignupEmailChange(e: any) -> None {
            signupEmail[1](e.target.value);
        }
        
        def handleSignupPasswordChange(e: any) -> None {
            signupPassword[1](e.target.value);
        }
        
        # Compute button text
        loginButtonText = "Sign In";
        if isLoading[0] {
            loginButtonText = "Signing in...";
        }
        
        signupButtonText = "Create Account";
        if isLoading[0] {
            signupButtonText = "Creating account...";
        }
        
        return <div className="min-h-screen bg-background flex flex-col">
            <div className="flex flex-1">
                # Left Panel - Visual (hidden on mobile, visible on desktop)
                <div className="hidden lg:flex lg:w-1/2 relative overflow-hidden">
                <div className="absolute inset-0 bg-gradient-hero" />
                <div className="absolute inset-0 bg-gradient-mesh" />
                <div className="absolute inset-0 bg-dots opacity-30" />
                <div className="absolute top-1/4 left-1/4 w-[400px] h-[400px] bg-primary/20 rounded-full blur-[100px]" />
                <div className="absolute bottom-1/4 right-1/4 w-[300px] h-[300px] bg-accent/20 rounded-full blur-[80px]" />
                
                # Theme Toggle (top-right)
                <div className="absolute top-6 right-6 z-20">
                    <ThemeToggle />
                </div>
                
                # Main content container
                <div className="relative z-10 flex flex-col justify-between p-12 w-full">
                    # Logo (top)
                    <Link to="/" className="flex items-center group">
                        <div className="relative">
                            <img 
                                src="/assets/illustrations/logo.png" 
                                alt="Skillverse Logo" 
                                className="w-32 h-32 sm:w-36 sm:h-36 md:w-40 md:h-40 lg:w-44 lg:h-44 xl:w-48 xl:h-48 object-contain group-hover:opacity-90 transition-opacity duration-300"
                            />
                        </div>
                    </Link>
                    
                    # Content (centered)
                    <div className="flex-1 flex items-center justify-center">
                        <div className="w-full max-w-md">
                            # Badge
                            <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full glass border border-primary/20 mb-8 hover:border-primary/40 transition-colors duration-300">
                                <FontAwesomeIcon icon={faMagic} className="w-4 h-4 text-primary" />
                                <span className="text-sm font-medium text-foreground">AI-Powered Platform</span>
                            </div>
                            
                            # Heading
                            <h1 className="font-display text-4xl sm:text-5xl md:text-6xl font-bold text-foreground mb-6 leading-tight tracking-tight">
                                Welcome to <span className="text-primary">Skillverse</span>
                            </h1>
                            
                            # Description
                            <div className="space-y-4 mb-10">
                                <p className="text-muted-foreground text-base sm:text-lg leading-relaxed">
                                    Your gateway to AI-powered career navigation. Sign in to access your personalized dashboard and start your journey.
                                </p>
                                <p className="text-muted-foreground text-sm sm:text-base leading-relaxed">
                                    New to Skillverse? Create an account to get started.
                                </p>
                            </div>
                            
                            # Illustration
                            <div className="h-64 sm:h-72 md:h-80 w-full flex items-center justify-center mt-8">
                                <img 
                                    src="/assets/illustrations/secure-login.svg" 
                                    alt="Secure login illustration" 
                                    className="max-h-full w-full object-contain drop-shadow-lg"
                                    loading="lazy"
                                />
                            </div>
                        </div>
                    </div>
                </div>
                </div>
                
                # Right Panel - Form
                <div className="w-full lg:w-1/2 flex items-center justify-center p-4 sm:p-6 md:p-8 relative">
                    <div className="absolute inset-0 bg-gradient-mesh lg:hidden" />
                    
                    <div className="w-full max-w-md relative z-10">
                    # Mobile Header
                    <div className="lg:hidden mb-8 flex items-center justify-between">
                        <Link to="/" className="flex items-center group">
                            <div className="relative">
                                <img 
                                    src="/assets/illustrations/logo.png" 
                                    alt="Skillverse Logo" 
                                    className="w-32 h-32 sm:w-36 sm:h-36 object-contain group-hover:opacity-90 transition-opacity duration-300"
                                />
                            </div>
                        </Link>
                        <ThemeToggle />
                    </div>
                    
                    # Back Link
                    <Link
                        to="/"
                        className="inline-flex items-center gap-2 text-muted-foreground hover:text-foreground transition-colors mb-8 text-sm group"
                    >
                        <FontAwesomeIcon icon={faArrowLeft} className="w-4 h-4 transition-transform group-hover:-translate-x-1" />
                        <span>Back to home</span>
                    </Link>
                    
                    # Toggle Switch 
                    <input type="checkbox" id="auth-toggle" className="sr-only peer" />
                    
                    # Login Form Header
                    <div className="mb-8 peer-checked:hidden">
                        <h2 className="font-display text-3xl sm:text-4xl md:text-5xl font-bold text-foreground mb-3 tracking-tight">
                            Welcome back
                        </h2>
                        <p className="text-muted-foreground text-base sm:text-lg md:text-xl">
                            Enter your credentials to continue
                        </p>
                    </div>
                    
                    # Error/Success messages
                    {errorMessage[0] && (
                        <div className="mb-4 p-3 rounded-lg bg-red-500/10 border border-red-500/20 text-red-500 text-sm">
                            {errorMessage[0]}
                        </div>
                    )}
                    {successMessage[0] && (
                        <div className="mb-4 p-3 rounded-lg bg-green-500/10 border border-green-500/20 text-green-500 text-sm">
                            {successMessage[0]}
                        </div>
                    )}
                    
                    # Login Form
                    <form onSubmit={handleLoginSubmit} className="space-y-5 md:space-y-6 peer-checked:hidden">
                        # Email field
                        <div>
                            <label className="block text-sm font-medium text-foreground mb-2.5">
                                Email
                            </label>
                            <div className="relative">
                                <FontAwesomeIcon icon={faEnvelope} className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground" />
                                <input
                                    type="email"
                                    placeholder="you@example.com"
                                    required
                                    value={loginEmail[0]}
                                    onChange={handleLoginEmailChange}
                                    className="w-full h-12 sm:h-13 pl-12 pr-4 text-sm sm:text-base rounded-xl bg-secondary/50 border border-border/50 text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-primary/50 transition-all duration-300"
                                />
                            </div>
                        </div>
                        
                        # Password field
                        <div>
                            <label className="block text-sm font-medium text-foreground mb-2.5">
                                Password
                            </label>
                            <div className="relative">
                                <FontAwesomeIcon icon={faLock} className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground" />
                                <input
                                    type="password"
                                    placeholder="••••••••"
                                    required
                                    value={loginPassword[0]}
                                    onChange={handleLoginPasswordChange}
                                    className="w-full h-12 sm:h-13 md:h-14 pl-12 pr-4 text-sm sm:text-base md:text-lg rounded-xl bg-secondary/50 border border-border/50 text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-primary/50 transition-all duration-300"
                                />
                            </div>
                        </div>
                        
                        # Forgot password
                        <div className="flex justify-end">
                            <a href="#" className="text-sm text-primary hover:underline">
                                Forgot password?
                            </a>
                        </div>
                        
                        # Submit button
                        <button
                            type="submit"
                            disabled={isLoading[0]}
                            className="w-full h-14 px-6 rounded-2xl font-semibold bg-gradient-primary text-white shadow-glow hover:opacity-90 transition-all duration-300 inline-flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed"
                        >
                            <span>{loginButtonText}</span>
                        </button>
                    </form>
                    
                    # Divider
                    <div className="relative my-8 peer-checked:hidden">
                        <div className="absolute inset-0 flex items-center">
                            <div className="w-full border-t border-border" />
                        </div>
                        <div className="relative flex justify-center text-xs uppercase">
                            <span className="bg-background px-4 text-muted-foreground">
                                Or continue with
                            </span>
                        </div>
                    </div>
                    
                    # Social login buttons
                    <div className="grid grid-cols-2 gap-4 peer-checked:hidden">
                        <button
                            type="button"
                            className="w-full h-12 px-4 rounded-xl glass border border-border/50 hover:bg-secondary/80 transition-all duration-300 inline-flex items-center justify-center gap-2 text-foreground"
                        >
                            <FontAwesomeIcon icon={faGoogle} className="w-5 h-5" />
                            <span>Google</span>
                        </button>
                        <button
                            type="button"
                            className="w-full h-12 px-4 rounded-xl glass border border-border/50 hover:bg-secondary/80 transition-all duration-300 inline-flex items-center justify-center gap-2 text-foreground"
                        >
                            <FontAwesomeIcon icon={faGithub} className="w-5 h-5" />
                            <span>GitHub</span>
                        </button>
                    </div>
                    
                    # Toggle Switch (placed at the very bottom like skill-navigator)
                    <div className="mt-8">
                        <div className="flex items-center justify-center gap-4 mb-4">
                            <span className="text-sm font-medium text-foreground auth-toggle-signin transition-colors duration-300">
                                Sign In
                            </span>
                            
                            <label htmlFor="auth-toggle" className="cursor-pointer">
                                <div className="relative w-16 h-8 rounded-full transition-all duration-300 auth-toggle-switch shadow-sm">
                                    <div className="absolute top-0.5 left-0.5 w-6 h-6 rounded-full shadow-lg flex items-center justify-center transition-transform duration-300 auth-toggle-button">
                                        <FontAwesomeIcon icon={faLock} className="w-3 h-3 absolute auth-toggle-icon" />
                                    </div>
                                </div>
                            </label>
                            
                            <span className="text-sm font-medium text-muted-foreground auth-toggle-signup transition-colors duration-300">
                                Sign Up
                            </span>
                        </div>
                        <p className="text-center text-xs text-muted-foreground">
                            <span className="peer-checked:hidden transition-opacity duration-300">New to Skillverse? Switch to create your account</span>
                            <span className="hidden peer-checked:inline transition-opacity duration-300">Already have an account? Switch to sign in</span>
                        </p>
                    </div>
                    
                    # Signup Form (hidden by default)
                    <div className="hidden peer-checked:block">
                        <div className="mb-8">
                            <h2 className="font-display text-3xl sm:text-4xl md:text-5xl font-bold text-foreground mb-3 tracking-tight">
                                Create account
                            </h2>
                            <p className="text-muted-foreground text-base sm:text-lg md:text-xl">
                                Start your career navigation journey
                            </p>
                        </div>
                        
                        <form onSubmit={handleSignupSubmit} className="space-y-5 md:space-y-6">
                            # Name field
                            <div>
                                <label className="block text-sm font-medium text-foreground mb-2.5">
                                    Full Name
                                </label>
                                <div className="relative">
                                    <FontAwesomeIcon icon={faUser} className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground" />
                                    <input
                                        type="text"
                                        placeholder="John Doe"
                                        required
                                        value={signupName[0]}
                                        onChange={handleSignupNameChange}
                                        className="w-full h-12 sm:h-13 pl-12 pr-4 text-sm sm:text-base rounded-xl bg-secondary/50 border border-border/50 text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-primary/50 transition-all duration-300"
                                    />
                                </div>
                            </div>
                            
                            # Email field
                            <div>
                                <label className="block text-sm font-medium text-foreground mb-2.5">
                                    Email
                                </label>
                                <div className="relative">
                                    <FontAwesomeIcon icon={faEnvelope} className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground" />
                                    <input
                                        type="email"
                                        placeholder="you@example.com"
                                        required
                                        value={signupEmail[0]}
                                        onChange={handleSignupEmailChange}
                                        className="w-full h-12 sm:h-13 pl-12 pr-4 text-sm sm:text-base rounded-xl bg-secondary/50 border border-border/50 text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-primary/50 transition-all duration-300"
                                    />
                                </div>
                            </div>
                            
                            # Password field
                            <div>
                                <label className="block text-sm font-medium text-foreground mb-2.5">
                                    Password
                                </label>
                                <div className="relative">
                                    <FontAwesomeIcon icon={faLock} className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground" />
                                    <input
                                        type="password"
                                        placeholder="••••••••"
                                        required
                                        value={signupPassword[0]}
                                        onChange={handleSignupPasswordChange}
                                        className="w-full h-12 sm:h-13 pl-12 pr-4 text-sm sm:text-base rounded-xl bg-secondary/50 border border-border/50 text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-primary/50 transition-all duration-300"
                                    />
                                </div>
                            </div>
                            
                            # Submit button
                            <button
                                type="submit"
                                disabled={isLoading[0]}
                                className="w-full h-12 sm:h-14 px-6 rounded-xl sm:rounded-2xl font-semibold bg-gradient-primary text-white shadow-glow hover:opacity-90 transition-all duration-300 inline-flex items-center justify-center gap-2 text-sm sm:text-base disabled:opacity-50 disabled:cursor-not-allowed"
                            >
                                <span>{signupButtonText}</span>
                            </button>
                        </form>
                        
                        # Divider
                        <div className="relative my-8">
                            <div className="absolute inset-0 flex items-center">
                                <div className="w-full border-t border-border" />
                            </div>
                            <div className="relative flex justify-center text-xs uppercase">
                                <span className="bg-background px-4 text-muted-foreground">
                                    Or continue with
                                </span>
                            </div>
                        </div>
                        
                        # Social login buttons
                        <div className="grid grid-cols-2 gap-4">
                            <button
                                type="button"
                                className="w-full h-12 px-4 rounded-xl glass border border-border/50 hover:bg-secondary/80 transition-all duration-300 inline-flex items-center justify-center gap-2 text-foreground"
                            >
                                <FontAwesomeIcon icon={faGoogle} className="w-5 h-5" />
                                <span>Google</span>
                            </button>
                            <button
                                type="button"
                                className="w-full h-12 px-4 rounded-xl glass border border-border/50 hover:bg-secondary/80 transition-all duration-300 inline-flex items-center justify-center gap-2 text-foreground"
                            >
                                <FontAwesomeIcon icon={faGithub} className="w-5 h-5" />
                                <span>GitHub</span>
                            </button>
                        </div>
                    </div>
                    </div>
                </div>
            </div>
            
            <Footer />
        </div>;
    }
    
    def DashboardPage() -> any {
        navigate = useNavigate();
        
        # Tab state
        tabState = useState("overview");
        activeTab = tabState[0];
        setActiveTab = tabState[1];
        
        # Mobile sidebar state
        sidebarState = useState(false);
        sidebarOpen = sidebarState[0];
        setSidebarOpen = sidebarState[1];
        
        # Overview tab state
        showAllSkillsState = useState(false);
        showAllSkills = showAllSkillsState[0];
        setShowAllSkills = showAllSkillsState[1];
        
        # Resume tab state
        isUploadingState = useState(false);
        isUploading = isUploadingState[0];
        setIsUploading = isUploadingState[1];
        
        isExtractingState = useState(false);
        isExtracting = isExtractingState[0];
        setIsExtracting = isExtractingState[1];
        
        extractedDataState = useState(null);
        extractedData = extractedDataState[0];
        setExtractedData = extractedDataState[1];
        
        uploadedFileState = useState(null);
        uploadedFile = uploadedFileState[0];
        setUploadedFile = uploadedFileState[1];
        
        # Resume file upload handler - helper functions
        def startExtraction() -> None {
            setIsUploading(false);
            setIsExtracting(true);
            setTimeout(completeExtraction, 2000);
        }
        
        def completeExtraction() -> None {
            # Mock extracted data
            setExtractedData({
                "skills": ["React", "TypeScript", "Node.js", "AWS", "Docker", "Leadership", "Communication"],
                "certifications": ["AWS Solutions Architect", "React Developer Certification"],
                "education": [
                    {"degree": "BSc Computer Science", "institution": "University of Nairobi", "year": "2020"}
                ],
                "experience": [
                    {"role": "Senior Frontend Developer", "company": "Tech Corp", "duration": "2021 - Present"},
                    {"role": "Frontend Developer", "company": "Startup Inc", "duration": "2019 - 2021"}
                ]
            });
            setIsExtracting(false);
        }
        
        def handleFileUpload(event: any) -> None {
            file = event.target.files[0];
            if not file {
                return;
            }
            
            setUploadedFile(file);
            setIsUploading(true);
            
            # Simulate upload
            setTimeout(startExtraction, 1500);
        }
        
        # Clear uploaded file
        def handleClearResume() -> None {
            setUploadedFile(null);
            setExtractedData(null);
        }
        
        # Career Targets tab state
        selectedTargetsState = useState([]);
        selectedTargets = selectedTargetsState[0];
        setSelectedTargets = selectedTargetsState[1];
        
        searchQueryState = useState("");
        searchQuery = searchQueryState[0];
        setSearchQuery = searchQueryState[1];
        
        activeCategoryState = useState("all");
        activeCategory = activeCategoryState[0];
        setActiveCategory = activeCategoryState[1];
        
        # Available targets data
        availableTargets = [
            {"id": "1", "title": "Senior Frontend Engineer", "category": "role", "match": 78, "demand": "high", "growth": 15},
            {"id": "2", "title": "Technical Lead", "category": "role", "match": 62, "demand": "high", "growth": 20},
            {"id": "3", "title": "Engineering Manager", "category": "role", "match": 45, "demand": "medium", "growth": 12},
            {"id": "4", "title": "Full-Stack Developer", "category": "track", "match": 70, "demand": "high", "growth": 18},
            {"id": "5", "title": "DevOps Engineer", "category": "track", "match": 35, "demand": "high", "growth": 25},
            {"id": "6", "title": "AI/ML Engineer", "category": "track", "match": 20, "demand": "high", "growth": 30},
            {"id": "7", "title": "System Design", "category": "skill", "match": 35, "demand": "high", "growth": 22},
            {"id": "8", "title": "AWS Cloud Architecture", "category": "skill", "match": 40, "demand": "high", "growth": 28},
            {"id": "9", "title": "Kubernetes", "category": "skill", "match": 25, "demand": "high", "growth": 35}
        ];
        
        # Filter targets
        filteredTargets = availableTargets.filter(lambda target: any -> bool {
            matchesSearch = target["title"].toLowerCase().includes(searchQuery.toLowerCase());
            matchesCategory = activeCategory == "all" or target["category"] == activeCategory;
            notSelected = not selectedTargets.find(lambda s: any -> bool: s["id"] == target["id"]);
            return matchesSearch and matchesCategory and notSelected;
        });
        
        # Handle select target
        def handleSelectTarget(target: any) -> None {
            newTargets = selectedTargets.copy();
            newTargets.append(target);
            setSelectedTargets(newTargets);
        }
        
        # Handle remove target
        def handleRemoveTarget(id: str) -> None {
            newTargets = selectedTargets.filter(lambda t: any -> bool: t["id"] != id);
            setSelectedTargets(newTargets);
        }
        
        # Get demand color
        def getDemandColor(demand: str) -> str {
            if demand == "high" {
                return "bg-accent/20 text-accent border-accent/30";
            } else {
                if demand == "medium" {
                    return "bg-primary/20 text-primary border-primary/30";
                } else {
                    return "bg-muted text-muted-foreground border-border";
                }
            }
        }
        
        # Navigate to gap analysis
        def handleNavigateToGapAnalysis() -> None {
            setActiveTab("gap-analysis");
        }
        
        # Handle search query change
        def handleSearchChange(event: any) -> None {
            setSearchQuery(event.target.value);
        }
        
        # Handle category change
        def handleCategoryChange(categoryId: str) -> None {
            setActiveCategory(categoryId);
        }
        
        # Skill Gap Analysis tab state
        isAnalyzingState = useState(false);
        isAnalyzing = isAnalyzingState[0];
        setIsAnalyzing = isAnalyzingState[1];
        
        analysisProgressState = useState(0);
        analysisProgress = analysisProgressState[0];
        setAnalysisProgress = analysisProgressState[1];
        
        showResultsState = useState(true);
        showResults = showResultsState[0];
        setShowResults = showResultsState[1];
        
        # Skill gaps data
        skillGaps = [
            {"skill": "System Design", "currentLevel": 35, "requiredLevel": 85, "gap": 50, "priority": "high", "marketDemand": 95, "category": "Architecture"},
            {"skill": "AWS Cloud", "currentLevel": 45, "requiredLevel": 80, "gap": 35, "priority": "high", "marketDemand": 90, "category": "Cloud"},
            {"skill": "Kubernetes", "currentLevel": 25, "requiredLevel": 70, "gap": 45, "priority": "high", "marketDemand": 88, "category": "DevOps"},
            {"skill": "Team Leadership", "currentLevel": 65, "requiredLevel": 80, "gap": 15, "priority": "medium", "marketDemand": 75, "category": "Soft"},
            {"skill": "GraphQL", "currentLevel": 40, "requiredLevel": 65, "gap": 25, "priority": "medium", "marketDemand": 70, "category": "Technical"},
            {"skill": "Microservices", "currentLevel": 50, "requiredLevel": 70, "gap": 20, "priority": "low", "marketDemand": 65, "category": "Architecture"}
        ];
        
        # Get priority color
        def getPriorityColor(priority: str) -> str {
            if priority == "high" {
                return "bg-red-500/20 text-red-400 border-red-500/30";
            } else {
                if priority == "medium" {
                    return "bg-yellow-500/20 text-yellow-400 border-yellow-500/30";
                } else {
                    return "bg-blue-500/20 text-blue-400 border-blue-500/30";
                }
            }
        }
        
        # Calculate stats
        highPriorityGaps = skillGaps.filter(lambda gap: any -> bool: gap["priority"] == "high");
        totalGap = 0;
        for gap in skillGaps {
            gapValue = truncToInt(gap["gap"]);
            totalGap = totalGap + gapValue;
        }
        avgGap = truncToInt(totalGap / skillGaps.length);
        
        # Start analysis
        def startAnalysis() -> None {
            setIsAnalyzing(true);
            setShowResults(false);
            setAnalysisProgress(0);
            
            # Simulate progress
            def updateProgress() -> None {
                currentProgress = analysisProgress;
                if currentProgress >= 100 {
                    setIsAnalyzing(false);
                    setShowResults(true);
                } else {
                    setAnalysisProgress(currentProgress + 10);
                    setTimeout(updateProgress, 300);
                }
            }
            setTimeout(updateProgress, 300);
        }
        
        # Learning Roadmap tab state
        selectedFilterState = useState("all");
        selectedFilter = selectedFilterState[0];
        setSelectedFilter = selectedFilterState[1];
        
        startingItemState = useState(null);
        startingItem = startingItemState[0];
        setStartingItem = startingItemState[1];
        
        continuingItemState = useState(null);
        continuingItem = continuingItemState[0];
        setContinuingItem = continuingItemState[1];
        
        isGeneratingState = useState(false);
        isGenerating = isGeneratingState[0];
        setIsGenerating = isGeneratingState[1];
        
        generateProgressState = useState(0);
        generateProgress = generateProgressState[0];
        setGenerateProgress = generateProgressState[1];
        
        # Roadmap items data
        roadmapItems = [
            {"id": "1", "title": "System Design Masterclass", "type": "course", "provider": "Educative", "duration": "8 weeks", "progress": 0, "status": "not-started", "priority": "high", "skills": ["System Design", "Architecture", "Scalability"], "estimatedCompletion": "2025-03-15"},
            {"id": "2", "title": "AWS Solutions Architect Associate", "type": "certification", "provider": "AWS", "duration": "6 weeks", "progress": 30, "status": "in-progress", "priority": "high", "skills": ["AWS", "Cloud Architecture", "DevOps"], "estimatedCompletion": "2025-02-28"},
            {"id": "3", "title": "Build Scalable Microservices API", "type": "project", "duration": "4 weeks", "progress": 10, "status": "in-progress", "priority": "high", "skills": ["Node.js", "Microservices", "API Design"], "estimatedCompletion": "2025-02-20"},
            {"id": "4", "title": "Kubernetes Fundamentals", "type": "course", "provider": "Pluralsight", "duration": "5 weeks", "progress": 0, "status": "not-started", "priority": "medium", "skills": ["Kubernetes", "Container Orchestration", "DevOps"], "estimatedCompletion": "2025-03-30"},
            {"id": "5", "title": "GraphQL API Development", "type": "course", "provider": "Frontend Masters", "duration": "3 weeks", "progress": 0, "status": "not-started", "priority": "medium", "skills": ["GraphQL", "API Design", "Backend"], "estimatedCompletion": "2025-03-10"},
            {"id": "6", "title": "Team Leadership Workshop", "type": "course", "provider": "LinkedIn Learning", "duration": "2 weeks", "progress": 75, "status": "in-progress", "priority": "low", "skills": ["Leadership", "Communication", "Management"], "estimatedCompletion": "2025-02-10"}
        ];
        
        # Filter roadmap items
        filteredRoadmapItems = roadmapItems.filter(lambda item: any -> bool {
            if selectedFilter == "all" {
                return true;
            }
            if selectedFilter == "high" {
                return item["priority"] == "high";
            }
            if selectedFilter == "in-progress" {
                return item["status"] == "in-progress";
            }
            return true;
        });
        
        # Calculate roadmap stats
        totalItems = roadmapItems.length;
        completedItems = roadmapItems.filter(lambda item: any -> bool: item["status"] == "completed");
        inProgressItems = roadmapItems.filter(lambda item: any -> bool: item["status"] == "in-progress");
        totalProgressSum = 0;
        for item in roadmapItems {
            progressValue = truncToInt(item["progress"]);
            totalProgressSum = totalProgressSum + progressValue;
        }
        avgProgress = truncToInt(totalProgressSum / totalItems);
        
        # Get type icon
        def getTypeIcon(type: str) -> any {
            if type == "course" {
                return faBook;
            } else {
                if type == "certification" {
                    return faAward;
                } else {
                    if type == "project" {
                        return faCode;
                    } else {
                        return faBook;
                    }
                }
            }
        }
        
        # Get type color
        def getTypeColor(type: str) -> str {
            if type == "course" {
                return "bg-primary/20 text-primary border-primary/30";
            } else {
                if type == "certification" {
                    return "bg-accent/20 text-accent border-accent/30";
                } else {
                    if type == "project" {
                        return "bg-purple-500/20 text-purple-400 border-purple-500/30";
                    } else {
                        return "bg-muted text-muted-foreground border-border";
                    }
                }
            }
        }
        
        # Handle filter change
        def handleFilterChange(filterId: str) -> None {
            setSelectedFilter(filterId);
        }
        
        # Handle start/continue item
        def handleItemAction(itemId: str, status: str) -> None {
            if status == "not-started" {
                setStartingItem(itemId);
                setTimeout(lambda: setStartingItem(null), 2000);
            } else {
                if status == "in-progress" {
                    setContinuingItem(itemId);
                    setTimeout(lambda: setContinuingItem(null), 1500);
                }
            }
        }
        
        # Generate new roadmap
        def handleGenerateRoadmap() -> None {
            setIsGenerating(true);
            setGenerateProgress(0);
            
            def updateGenerateProgress() -> None {
                currentProgress = generateProgress;
                if currentProgress >= 100 {
                    setIsGenerating(false);
                    setGenerateProgress(0);
                } else {
                    setGenerateProgress(currentProgress + 5);
                    setTimeout(updateGenerateProgress, 100);
                }
            }
            setTimeout(updateGenerateProgress, 100);
        }
        
        # Market Intelligence tab state
        marketTrends = [
            {"skill": "Kubernetes", "category": "DevOps", "currentDemand": 88, "change": 15, "trend": "up", "growth": 35},
            {"skill": "System Design", "category": "Architecture", "currentDemand": 95, "change": 8, "trend": "up", "growth": 22},
            {"skill": "AWS Cloud", "category": "Cloud", "currentDemand": 90, "change": 12, "trend": "up", "growth": 28},
            {"skill": "GraphQL", "category": "Technical", "currentDemand": 70, "change": -5, "trend": "down", "growth": 10},
            {"skill": "React", "category": "Frontend", "currentDemand": 85, "change": 3, "trend": "stable", "growth": 5},
            {"skill": "TypeScript", "category": "Language", "currentDemand": 82, "change": 10, "trend": "up", "growth": 18}
        ];
        
        marketAlerts = [
            {"id": "1", "type": "emerging", "title": "New Emerging Skill", "description": "Kubernetes demand increased by 35% this quarter", "skill": "Kubernetes", "timestamp": "2 hours ago"},
            {"id": "2", "type": "hot", "title": "High Demand Alert", "description": "System Design roles increased by 22% in job postings", "skill": "System Design", "timestamp": "5 hours ago"},
            {"id": "3", "type": "declining", "title": "Declining Trend", "description": "GraphQL demand decreased by 5% - consider alternatives", "skill": "GraphQL", "timestamp": "1 day ago"}
        ];
        
        # Get trend icon
        def getTrendIcon(trend: str) -> any {
            if trend == "up" {
                return faArrowUp;
            } else {
                if trend == "down" {
                    return faArrowDown;
                } else {
                    return faBarChart;
                }
            }
        }
        
        # Get alert color
        def getAlertColor(type: str) -> str {
            if type == "emerging" {
                return "bg-accent/10 border-accent/20 text-accent";
            } else {
                if type == "hot" {
                    return "bg-red-500/10 border-red-500/20 text-red-400";
                } else {
                    if type == "declining" {
                        return "bg-yellow-500/10 border-yellow-500/20 text-yellow-400";
                    } else {
                        return "bg-muted border-border text-muted-foreground";
                    }
                }
            }
        }
        
        # Progress Tracking tab state
        progressItems = [
            {"id": "1", "type": "skill", "title": "System Design", "progress": 65, "target": 85, "status": "in-progress", "category": "Architecture"},
            {"id": "2", "type": "course", "title": "AWS Solutions Architect", "progress": 30, "target": 100, "status": "in-progress", "category": "Cloud"},
            {"id": "3", "type": "certification", "title": "React Developer Certification", "progress": 100, "target": 100, "status": "completed", "completedDate": "2025-01-15", "category": "Frontend"},
            {"id": "4", "type": "skill", "title": "Kubernetes", "progress": 25, "target": 70, "status": "in-progress", "category": "DevOps"},
            {"id": "5", "type": "course", "title": "Team Leadership Workshop", "progress": 75, "target": 100, "status": "in-progress", "category": "Soft Skills"},
            {"id": "6", "type": "skill", "title": "GraphQL", "progress": 40, "target": 65, "status": "in-progress", "category": "Technical"}
        ];
        
        # Calculate progress stats
        completedProgressCount = progressItems.filter(lambda item: any -> bool: item["status"] == "completed");
        inProgressProgressCount = progressItems.filter(lambda item: any -> bool: item["status"] == "in-progress");
        totalProgressSum2 = 0;
        for item in progressItems {
            progressValue2 = truncToInt(item["progress"]);
            totalProgressSum2 = totalProgressSum2 + progressValue2;
        }
        totalProgress = truncToInt(totalProgressSum2 / progressItems.length);
        
        # Get progress type icon
        def getProgressTypeIcon(type: str) -> any {
            if type == "skill" {
                return faBullseye;
            } else {
                if type == "course" {
                    return faWandMagicSparkles;
                } else {
                    if type == "certification" {
                        return faAward;
                    } else {
                        return faBullseye;
                    }
                }
            }
        }
        
        # Get progress type color
        def getProgressTypeColor(type: str) -> str {
            if type == "skill" {
                return "bg-primary/20 text-primary border-primary/30";
            } else {
                if type == "course" {
                    return "bg-accent/20 text-accent border-accent/30";
                } else {
                    if type == "certification" {
                        return "bg-purple-500/20 text-purple-400 border-purple-500/30";
                    } else {
                        return "bg-muted text-muted-foreground border-border";
                    }
                }
            }
        }
        
        # Profile tab state
        isEditingState = useState(false);
        isEditing = isEditingState[0];
        setIsEditing = isEditingState[1];
        
        profileDataState = useState({
            "name": "John Doe",
            "email": "john@example.com",
            "bio": "Passionate full-stack developer with expertise in React, TypeScript, and cloud technologies. Always learning and building innovative solutions.",
            "location": "Nairobi, Kenya",
            "currentRole": "Senior Frontend Developer",
            "company": "Tech Corp",
            "education": "BSc Computer Science, University of Nairobi (2020)",
            "joinDate": "January 2024",
            "linkedin": "linkedin.com/in/johndoe",
            "github": "github.com/johndoe",
            "twitter": "@johndoe"
        });
        profileData = profileDataState[0];
        setProfileData = profileDataState[1];
        
        tempDataState = useState(profileData);
        tempData = tempDataState[0];
        setTempData = tempDataState[1];
        
        avatarPreviewState = useState(null);
        avatarPreview = avatarPreviewState[0];
        setAvatarPreview = avatarPreviewState[1];
        
        # Profile handlers
        def handleEditProfile() -> None {
            setTempData(profileData);
            setIsEditing(true);
        }
        
        def handleCancelEdit() -> None {
            setTempData(profileData);
            setIsEditing(false);
            setAvatarPreview(null);
        }
        
        def handleSaveProfile() -> None {
            setProfileData(tempData);
            setIsEditing(false);
            setAvatarPreview(null);
        }
        
        def handleAvatarChange(event: any) -> None {
            file = event.target.files[0];
            if file {
                # Simplified avatar handling - just set the file name for now
                setAvatarPreview(file.name);
                newTempData = {};
                for key in tempData {
                    newTempData[key] = tempData[key];
                }
                newTempData["avatar"] = file.name;
                setTempData(newTempData);
            }
        }
        
        # Calculate profile completion
        def calculateProfileCompletion() -> float {
            filled = 0;
            total = 10;
            if profileData["name"] {
                filled = filled + 1;
            }
            if profileData["email"] {
                filled = filled + 1;
            }
            if profileData["bio"] {
                filled = filled + 1;
            }
            if profileData["location"] {
                filled = filled + 1;
            }
            if profileData["currentRole"] {
                filled = filled + 1;
            }
            if profileData["company"] {
                filled = filled + 1;
            }
            if profileData["education"] {
                filled = filled + 1;
            }
            if profileData["linkedin"] or profileData["github"] or profileData["twitter"] {
                filled = filled + 1;
            }
            if "phone" in profileData and profileData["phone"] {
                filled = filled + 1;
            }
            if "avatar" in profileData and profileData["avatar"] {
                filled = filled + 1;
            }
            return truncToInt((filled / total) * 100);
        }
        
        profileCompletion = calculateProfileCompletion();
        
        # Truncate to integer without using int() (compiler emits broken new func() in browser)
        def truncToInt(x: float) -> float {
            return x - (x % 1);
        }
        # Helper function to format percentage for style (avoid str() - compiles to new func in browser)
        def formatPercent(value: float) -> str {
            return (value + "") + "%";
        }
        
        # Toggle mobile sidebar
        def toggleSidebar() -> None {
            setSidebarOpen(not sidebarOpen);
        }
        
        # Close mobile sidebar
        def closeSidebar() -> None {
            setSidebarOpen(false);
        }
        
        # Tab change handlers
        def handleOverviewTab() -> None {
            setActiveTab("overview");
            closeSidebar();
        }
        def handleResumeTab() -> None {
            setActiveTab("resume");
            closeSidebar();
        }
        def handleTargetsTab() -> None {
            setActiveTab("targets");
            closeSidebar();
        }
        def handleGapAnalysisTab() -> None {
            setActiveTab("gap-analysis");
            closeSidebar();
        }
        def handleRoadmapTab() -> None {
            setActiveTab("roadmap");
            closeSidebar();
        }
        def handleMarketTab() -> None {
            setActiveTab("market");
            closeSidebar();
        }
        def handleProgressTab() -> None {
            setActiveTab("progress");
            closeSidebar();
        }
        def handleProfileTab() -> None {
            setActiveTab("profile");
            closeSidebar();
        }
        
        # Full View button handler for Career Graph
        def handleFullViewGraph() -> None {
            graphElement = document.querySelector("[data-career-graph]");
            if graphElement {
                graphElement.scrollIntoView({"behavior": "smooth", "block": "start"});
            }
        }
        
        # Desktop tab handlers (no sidebar close)
        def handleOverviewTabDesktop() -> None {
            setActiveTab("overview");
        }
        def handleResumeTabDesktop() -> None {
            setActiveTab("resume");
        }
        def handleTargetsTabDesktop() -> None {
            setActiveTab("targets");
        }
        def handleGapAnalysisTabDesktop() -> None {
            setActiveTab("gap-analysis");
        }
        def handleRoadmapTabDesktop() -> None {
            setActiveTab("roadmap");
        }
        def handleMarketTabDesktop() -> None {
            setActiveTab("market");
        }
        def handleProgressTabDesktop() -> None {
            setActiveTab("progress");
        }
        def handleProfileTabDesktop() -> None {
            setActiveTab("profile");
        }
        
        # Handle logout (call @jac/runtime helper + navigate)
        async def handleLogout() -> None {
            try {
                jacLogout();
            } except Exception as err {
                console.error("Logout error:", err);
            }
            navigate("/");
        }
        
        # Get user info (mock for now - will connect to backend later)
        userInfo = {
            "name": "John Doe",
            "email": "john@example.com",
            "initials": "JD"
        };
        
        # Navigation items
        navItems = [
            {"icon": faChartLine, "label": "Overview", "id": "overview"},
            {"icon": faFileText, "label": "Resume", "id": "resume"},
            {"icon": faBullseye, "label": "Career Targets", "id": "targets"},
            {"icon": faArrowUp, "label": "Skill Gap", "id": "gap-analysis"},
            {"icon": faBook, "label": "Learning Roadmap", "id": "roadmap"},
            {"icon": faGlobe, "label": "Market Intelligence", "id": "market"},
            {"icon": faWandMagicSparkles, "label": "Progress", "id": "progress"},
            {"icon": faUser, "label": "Profile", "id": "profile"}
        ];
        
        # Overview tab data
        allSkills = [
            {"name": "React", "level": 85, "category": "Technical"},
            {"name": "TypeScript", "level": 78, "category": "Technical"},
            {"name": "Leadership", "level": 65, "category": "Soft"},
            {"name": "Data Analysis", "level": 55, "category": "Technical"},
            {"name": "Communication", "level": 80, "category": "Soft"},
            {"name": "Node.js", "level": 70, "category": "Technical"},
            {"name": "AWS", "level": 45, "category": "Cloud"},
            {"name": "Docker", "level": 60, "category": "DevOps"},
            {"name": "System Design", "level": 35, "category": "Architecture"},
            {"name": "Kubernetes", "level": 25, "category": "DevOps"},
            {"name": "GraphQL", "level": 40, "category": "Technical"},
            {"name": "Python", "level": 50, "category": "Language"},
            {"name": "SQL", "level": 65, "category": "Database"},
            {"name": "MongoDB", "level": 55, "category": "Database"},
            {"name": "Git", "level": 80, "category": "DevOps"},
            {"name": "CI/CD", "level": 45, "category": "DevOps"},
            {"name": "Agile", "level": 70, "category": "Soft"},
            {"name": "Problem Solving", "level": 75, "category": "Soft"},
            {"name": "Team Management", "level": 60, "category": "Soft"},
            {"name": "Project Management", "level": 55, "category": "Soft"}
        ];
        
        # Filter skills based on showAllSkills state
        if showAllSkills {
            skills = allSkills;
        } else {
            skills = allSkills[0:5];
        }
        
        learningPath = [
            {"title": "Advanced React Patterns", "progress": 75, "type": "Course"},
            {"title": "AWS Certification", "progress": 30, "type": "Certification"},
            {"title": "Build Portfolio Project", "progress": 10, "type": "Project"}
        ];
        
        targetRoles = [
            {"title": "Senior Frontend Engineer", "match": 78},
            {"title": "Technical Lead", "match": 62},
            {"title": "Engineering Manager", "match": 45}
        ];
        
        # Find current tab label
        currentTab = None;
        for item in navItems {
            if item["id"] == activeTab {
                currentTab = item;
                break;
            }
        }
        tabLabel = currentTab["label"] if currentTab else "Dashboard";
        
        # Compute className for each nav button (mobile)
        if activeTab == "overview" {
            overviewClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm bg-primary/10 text-primary font-medium";
        } else {
            overviewClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        }
        
        if activeTab == "resume" {
            resumeClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm bg-primary/10 text-primary font-medium";
        } else {
            resumeClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        }
        
        if activeTab == "targets" {
            targetsClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm bg-primary/10 text-primary font-medium";
        } else {
            targetsClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        }
        
        if activeTab == "gap-analysis" {
            gapClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm bg-primary/10 text-primary font-medium";
        } else {
            gapClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        }
        
        if activeTab == "roadmap" {
            roadmapClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm bg-primary/10 text-primary font-medium";
        } else {
            roadmapClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        }
        
        if activeTab == "market" {
            marketClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm bg-primary/10 text-primary font-medium";
        } else {
            marketClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        }
        
        if activeTab == "progress" {
            progressClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm bg-primary/10 text-primary font-medium";
        } else {
            progressClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        }
        
        if activeTab == "profile" {
            profileClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm bg-primary/10 text-primary font-medium";
        } else {
            profileClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        }
        
        # Compute className for desktop nav buttons
        baseClassDesktop = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all relative text-sm shrink-0 ";
        activeClassDesktop = "bg-primary/10 text-primary font-medium";
        inactiveClassDesktop = "text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        
        # Initialize all desktop class variables first
        overviewClassDesktop = baseClassDesktop + inactiveClassDesktop;
        resumeClassDesktop = baseClassDesktop + inactiveClassDesktop;
        targetsClassDesktop = baseClassDesktop + inactiveClassDesktop;
        gapClassDesktop = baseClassDesktop + inactiveClassDesktop;
        roadmapClassDesktop = baseClassDesktop + inactiveClassDesktop;
        marketClassDesktop = baseClassDesktop + inactiveClassDesktop;
        progressClassDesktop = baseClassDesktop + inactiveClassDesktop;
        profileClassDesktop = baseClassDesktop + inactiveClassDesktop;
        
        # Update active tab class
        if activeTab == "overview" {
            overviewClassDesktop = baseClassDesktop + activeClassDesktop;
        }
        if activeTab == "resume" {
            resumeClassDesktop = baseClassDesktop + activeClassDesktop;
        }
        if activeTab == "targets" {
            targetsClassDesktop = baseClassDesktop + activeClassDesktop;
        }
        if activeTab == "gap-analysis" {
            gapClassDesktop = baseClassDesktop + activeClassDesktop;
        }
        if activeTab == "roadmap" {
            roadmapClassDesktop = baseClassDesktop + activeClassDesktop;
        }
        if activeTab == "market" {
            marketClassDesktop = baseClassDesktop + activeClassDesktop;
        }
        if activeTab == "progress" {
            progressClassDesktop = baseClassDesktop + activeClassDesktop;
        }
        if activeTab == "profile" {
            profileClassDesktop = baseClassDesktop + activeClassDesktop;
        }
        
        # Compute icon classes for desktop
        # Initialize all icon classes first
        iconClassOverview = "w-4 h-4 relative z-10";
        iconClassResume = "w-4 h-4 relative z-10";
        iconClassTargets = "w-4 h-4 relative z-10";
        iconClassGap = "w-4 h-4 relative z-10";
        iconClassRoadmap = "w-4 h-4 relative z-10";
        iconClassMarket = "w-4 h-4 relative z-10";
        iconClassProgress = "w-4 h-4 relative z-10";
        iconClassProfile = "w-4 h-4 relative z-10";
        
        # Update active tab icon class
        if activeTab == "overview" {
            iconClassOverview = "w-4 h-4 relative z-10 text-primary";
        }
        if activeTab == "resume" {
            iconClassResume = "w-4 h-4 relative z-10 text-primary";
        }
        if activeTab == "targets" {
            iconClassTargets = "w-4 h-4 relative z-10 text-primary";
        }
        if activeTab == "gap-analysis" {
            iconClassGap = "w-4 h-4 relative z-10 text-primary";
        }
        if activeTab == "roadmap" {
            iconClassRoadmap = "w-4 h-4 relative z-10 text-primary";
        }
        if activeTab == "market" {
            iconClassMarket = "w-4 h-4 relative z-10 text-primary";
        }
        if activeTab == "progress" {
            iconClassProgress = "w-4 h-4 relative z-10 text-primary";
        }
        if activeTab == "profile" {
            iconClassProfile = "w-4 h-4 relative z-10 text-primary";
        }
        
        # Compute active tab indicators for desktop sidebar
        overviewIndicator = None;
        if activeTab == "overview" {
            overviewIndicator = <div className="absolute left-0 inset-y-1.5 w-0.5 bg-primary rounded-r-full" />;
        }
        resumeIndicator = None;
        if activeTab == "resume" {
            resumeIndicator = <div className="absolute left-0 inset-y-1.5 w-0.5 bg-primary rounded-r-full" />;
        }
        targetsIndicator = None;
        if activeTab == "targets" {
            targetsIndicator = <div className="absolute left-0 inset-y-1.5 w-0.5 bg-primary rounded-r-full" />;
        }
        gapIndicator = None;
        if activeTab == "gap-analysis" {
            gapIndicator = <div className="absolute left-0 inset-y-1.5 w-0.5 bg-primary rounded-r-full" />;
        }
        roadmapIndicator = None;
        if activeTab == "roadmap" {
            roadmapIndicator = <div className="absolute left-0 inset-y-1.5 w-0.5 bg-primary rounded-r-full" />;
        }
        marketIndicator = None;
        if activeTab == "market" {
            marketIndicator = <div className="absolute left-0 inset-y-1.5 w-0.5 bg-primary rounded-r-full" />;
        }
        progressIndicator = None;
        if activeTab == "progress" {
            progressIndicator = <div className="absolute left-0 inset-y-1.5 w-0.5 bg-primary rounded-r-full" />;
        }
        profileIndicator = None;
        if activeTab == "profile" {
            profileIndicator = <div className="absolute left-0 inset-y-1.5 w-0.5 bg-primary rounded-r-full" />;
        }
        
        # Mobile sidebar content - AnimatePresence + motion (match skill-navigator)
        mobileSidebar = <AnimatePresence>
            {sidebarOpen && <div>
                <motion.div
                    initial={{"opacity": 0}}
                    animate={{"opacity": 1}}
                    exit={{"opacity": 0}}
                    onClick={closeSidebar}
                    className="fixed inset-0 bg-background/80 backdrop-blur-sm z-40 lg:hidden"
                />
                <motion.aside
                    initial={{"x": -280}}
                    animate={{"x": 0}}
                    exit={{"x": -280}}
                    transition={{"type": "spring", "damping": 25, "stiffness": 200}}
                    className="fixed left-0 top-0 h-full w-70 bg-background/95 backdrop-blur-xl border-r border-border/50 z-50 lg:hidden"
                >
                    <div className="p-5 h-full flex flex-col">
                        <div className="flex items-center justify-between mb-8 shrink-0">
                            <Link to="/" className="flex items-center">
                                <img 
                                    src="/static/assets/illustrations/logo.png"
                                    alt="Skillverse Logo"
                                    className="w-32 h-32 sm:w-36 sm:h-36 md:w-40 md:h-40 object-contain"
                                />
                            </Link>
                            <button
                                onClick={closeSidebar}
                                className="p-2 rounded-lg hover:bg-secondary/50 transition-colors"
                            >
                                <X className="w-5 h-5" />
                            </button>
                        </div>
                        
                        <nav className="space-y-1 flex-1 overflow-y-auto overflow-x-hidden pr-1 -mr-1 scrollbar-thin scrollbar-thumb-border scrollbar-track-transparent hover:scrollbar-thumb-border/50">
                            <motion.button onClick={handleOverviewTab} className={overviewClassMobile} initial={{"opacity": 0, "x": -20}} animate={{"opacity": 1, "x": 0}} transition={{"delay": 0.03}}>
                                <BarChart3 className={activeTab == "overview" and "w-4 h-4 text-primary" or "w-4 h-4"} />
                                <span>Overview</span>
                            </motion.button>
                            <motion.button onClick={handleResumeTab} className={resumeClassMobile} initial={{"opacity": 0, "x": -20}} animate={{"opacity": 1, "x": 0}} transition={{"delay": 0.06}}>
                                <FileText className={activeTab == "resume" and "w-4 h-4 text-primary" or "w-4 h-4"} />
                                <span>Resume</span>
                            </motion.button>
                            <motion.button onClick={handleTargetsTab} className={targetsClassMobile} initial={{"opacity": 0, "x": -20}} animate={{"opacity": 1, "x": 0}} transition={{"delay": 0.09}}>
                                <Target className={activeTab == "targets" and "w-4 h-4 text-primary" or "w-4 h-4"} />
                                <span>Career Targets</span>
                            </motion.button>
                            <motion.button onClick={handleGapAnalysisTab} className={gapClassMobile} initial={{"opacity": 0, "x": -20}} animate={{"opacity": 1, "x": 0}} transition={{"delay": 0.12}}>
                                <TrendingUp className={activeTab == "gap-analysis" and "w-4 h-4 text-primary" or "w-4 h-4"} />
                                <span>Skill Gap</span>
                            </motion.button>
                            <motion.button onClick={handleRoadmapTab} className={roadmapClassMobile} initial={{"opacity": 0, "x": -20}} animate={{"opacity": 1, "x": 0}} transition={{"delay": 0.15}}>
                                <BookOpen className={activeTab == "roadmap" and "w-4 h-4 text-primary" or "w-4 h-4"} />
                                <span>Learning Roadmap</span>
                            </motion.button>
                            <motion.button onClick={handleMarketTab} className={marketClassMobile} initial={{"opacity": 0, "x": -20}} animate={{"opacity": 1, "x": 0}} transition={{"delay": 0.18}}>
                                <Network className={activeTab == "market" and "w-4 h-4 text-primary" or "w-4 h-4"} />
                                <span>Market Intelligence</span>
                            </motion.button>
                            <motion.button onClick={handleProgressTab} className={progressClassMobile} initial={{"opacity": 0, "x": -20}} animate={{"opacity": 1, "x": 0}} transition={{"delay": 0.21}}>
                                <Sparkles className={activeTab == "progress" and "w-4 h-4 text-primary" or "w-4 h-4"} />
                                <span>Progress</span>
                            </motion.button>
                            <motion.button onClick={handleProfileTab} className={profileClassMobile} initial={{"opacity": 0, "x": -20}} animate={{"opacity": 1, "x": 0}} transition={{"delay": 0.24}}>
                                <User className={activeTab == "profile" and "w-4 h-4 text-primary" or "w-4 h-4"} />
                                <span>Profile</span>
                            </motion.button>
                        </nav>
                        
                        <div className="border-t border-border/50 pt-4 mt-auto shrink-0">
                            <motion.button
                                onClick={handleProfileTab}
                                whileHover={{"scale": 1.01}}
                                whileTap={{"scale": 0.99}}
                                className="flex items-center gap-3 mb-3 w-full p-2 rounded-lg hover:bg-secondary/50 transition-colors"
                            >
                                <div className="w-9 h-9 rounded-full bg-gradient-primary flex items-center justify-center overflow-hidden flex-shrink-0">
                                    <span className="font-semibold text-primary-foreground text-xs">{userInfo["initials"]}</span>
                                </div>
                                <div className="flex-1 min-w-0 text-left">
                                    <p className="font-medium text-foreground text-sm truncate">{userInfo["name"]}</p>
                                    <p className="text-muted-foreground text-xs truncate">{userInfo["email"]}</p>
                                </div>
                            </motion.button>
                            <div className="flex gap-1.5">
                                <button 
                                    onClick={handleProfileTab}
                                    className="flex-1 h-8 w-8 rounded-lg hover:bg-secondary/50 transition-colors flex items-center justify-center"
                                    title="Profile Settings"
                                >
                                    <Settings className="w-4 h-4" />
                                </button>
                                <ThemeToggle />
                                <button 
                                    onClick={handleLogout}
                                    className="h-8 w-8 rounded-lg hover:bg-secondary/50 transition-colors flex items-center justify-center"
                                    title="Logout"
                                >
                                    <LogOut className="w-4 h-4" />
                                </button>
                            </div>
                        </div>
                    </div>
                </motion.aside>
            </div>}
        </AnimatePresence>;
        
        def renderRoadmapItem(item: dict) -> any {
            typeIcon = getTypeIcon(item["type"]);
            typeColor = getTypeColor(item["type"]);
            priorityColor = getPriorityColor(item["priority"]);
            isStarting = startingItem == item["id"];
            isContinuing = continuingItem == item["id"];
            return <div key={item["id"]} className="rounded-lg bg-card border border-border/50 p-4 sm:p-5 hover:border-primary/30 transition-all">
                <div className="flex items-start justify-between mb-4">
                    <div className="flex items-start gap-4 flex-1">
                        <div className={item["status"] == "completed" and "w-12 h-12 rounded-xl flex items-center justify-center bg-green-500/20 border-2 border-green-500/30" or item["status"] == "in-progress" and "w-12 h-12 rounded-xl flex items-center justify-center bg-primary/20 border-2 border-primary/30" or "w-12 h-12 rounded-xl flex items-center justify-center bg-secondary border-2 border-border"}>
                            <FontAwesomeIcon icon={typeIcon} className={item["status"] == "completed" and "w-6 h-6 text-green-400" or item["status"] == "in-progress" and "w-6 h-6 text-primary" or "w-6 h-6 text-muted-foreground"} />
                        </div>
                        <div className="flex-1">
                            <div className="flex items-center gap-2 mb-2">
                                <h4 className="font-display font-bold text-lg text-foreground">{item["title"]}</h4>
                                {item["status"] == "completed" and (
                                    <FontAwesomeIcon icon={faCheckCircle} className="w-5 h-5 text-green-400" />
                                )}
                            </div>
                            <div className="flex flex-wrap items-center gap-2 mb-2">
                                <span className={"inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors " + typeColor}>
                                    {item["type"]}
                                </span>
                                {"provider" in item and item["provider"] and (
                                    <span className="text-xs text-muted-foreground">{item["provider"]}</span>
                                )}
                                <span className={"inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors " + priorityColor}>
                                    {item["priority"]} priority
                                </span>
                            </div>
                            <div className="flex items-center gap-4 text-xs text-muted-foreground">
                                <div className="flex items-center gap-1">
                                    <FontAwesomeIcon icon={faClock} className="w-3 h-3" />
                                    <span>{item["duration"]}</span>
                                </div>
                                {"estimatedCompletion" in item and item["estimatedCompletion"] and (
                                    <div className="flex items-center gap-1">
                                        <FontAwesomeIcon icon={faCalendar} className="w-3 h-3" />
                                        <span>Due: {item["estimatedCompletion"]}</span>
                                    </div>
                                )}
                            </div>
                        </div>
                        <button
                            onClick={lambda: handleItemAction(item["id"], item["status"])}
                            disabled={isStarting or isContinuing}
                            className={item["status"] == "not-started" and "shrink-0 inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-xl text-sm font-semibold font-display transition-all duration-300 h-9 px-4 bg-gradient-primary text-primary-foreground hover:opacity-90 shadow-lg shadow-primary/20" or "shrink-0 inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-lg text-xs font-semibold font-display transition-all duration-300 h-9 px-4 border-2 border-border bg-transparent hover:bg-secondary text-foreground hover:border-primary/50"}
                        >
                            {isStarting and (
                                <span className="inline-flex items-center">
                                    <FontAwesomeIcon icon={faCircleNotch} className="w-4 h-4 mr-1 animate-spin" />
                                    Starting...
                                </span>
                            ) or isContinuing and (
                                <span className="inline-flex items-center">
                                    <FontAwesomeIcon icon={faCircleNotch} className="w-4 h-4 mr-1 animate-spin" />
                                    Loading...
                                </span>
                            ) or item["status"] == "not-started" and (
                                <span className="inline-flex items-center">
                                    Start <FontAwesomeIcon icon={faPlay} className="w-4 h-4 ml-1" />
                                </span>
                            ) or item["status"] == "in-progress" and (
                                <span className="inline-flex items-center">
                                    Continue <FontAwesomeIcon icon={faArrowRight} className="w-4 h-4 ml-1" />
                                </span>
                            ) or (
                                <span>Review</span>
                            )}
                        </button>
                    </div>
                    {item["status"] != "not-started" and (
                        <div className="mb-3">
                            <div className="flex items-center justify-between mb-1.5">
                                <span className="text-xs text-muted-foreground">Progress</span>
                                <span className="text-xs font-medium text-foreground">{String(item["progress"])}%</span>
                            </div>
                            <div className="h-1.5 rounded-full bg-background overflow-hidden">
                                <div
                                    className={item["progress"] >= 75 and "h-full rounded-full bg-accent" or item["progress"] >= 50 and "h-full rounded-full bg-primary" or "h-full rounded-full bg-primary/70"}
                                    style={{"width": formatPercent(item["progress"])}}
                                />
                            </div>
                        </div>
                    )}
                    <div>
                        <p className="text-xs text-muted-foreground mb-2">Skills you'll learn:</p>
                        <div className="flex flex-wrap gap-1.5">
                            {item["skills"].map(lambda skill: any -> any { return <span key={skill} className="inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors text-[10px] px-1.5 py-0.5 bg-primary/5 text-primary border-primary/20">{skill}</span>; })}
                        </div>
                    </div>
                </div>
            </div>;
        }
        
        roadmapGenerateBlock = None;
        if isGenerating {
            roadmapGenerateBlock = <div className="space-y-3">
                <div className="flex items-center gap-3">
                    <FontAwesomeIcon icon={faCircleNotch} className="w-6 h-6 text-primary animate-spin" />
                    <div className="flex-1">
                        <h4 className="font-display text-sm font-semibold text-foreground mb-1">Generating Roadmap</h4>
                        <p className="text-xs text-muted-foreground">byLLM AI is creating your personalized learning path...</p>
                    </div>
                </div>
                <div className="space-y-2">
                    <div className="flex items-center justify-between text-xs">
                        <span className="text-muted-foreground">Progress</span>
                        <span className="font-medium text-foreground">{String(generateProgress)}%</span>
                    </div>
                    <div className="h-2 rounded-full bg-secondary overflow-hidden">
                        <div className="h-full bg-primary rounded-full" style={{"width": formatPercent(generateProgress)}} />
                    </div>
                    <div className="flex items-center gap-2 text-xs text-muted-foreground mt-2">
                        <FontAwesomeIcon icon={faWandMagicSparkles} className="w-3 h-3" />
                        <span>Analyzing skills, goals, and market trends...</span>
                    </div>
                </div>
            </div>;
        } else {
            roadmapGenerateBlock = <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                <div className="flex-1">
                    <h4 className="font-display text-sm font-semibold text-foreground mb-1">Need a new roadmap?</h4>
                    <p className="text-xs text-muted-foreground">Generate a personalized learning path with byLLM AI based on your updated skills, goals, and OSP graph data</p>
                </div>
                <button onClick={handleGenerateRoadmap} disabled={isGenerating} className="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-xl text-sm font-semibold font-display transition-all duration-300 h-11 px-6 py-2 bg-primary text-primary-foreground hover:brightness-110 shadow-md hover:shadow-lg">
                    <FontAwesomeIcon icon={faWandMagicSparkles} className="w-4 h-4 mr-2" />
                    Generate New
                </button>
            </div>;
        }
        
        # Dashboard layout matching skill-navigator: fixed sidebar (tab links) + main (tab content)
        return <div className="min-h-screen bg-background">
            {mobileSidebar}
            
            # Desktop Sidebar - fixed left, w-64, motion + Lucide (match skill-navigator)
            <aside className="fixed left-0 top-0 h-full w-64 bg-background/95 backdrop-blur-xl border-r border-border/50 z-50 hidden lg:block">
                <div className="p-5 h-full flex flex-col">
                    <Link to="/" className="flex items-center mb-8 group shrink-0">
                        <motion.div whileHover={{"scale": 1.05}} whileTap={{"scale": 0.95}}>
                            <img 
                                src="/static/assets/illustrations/logo.png"
                                alt="Skillverse Logo"
                                className="w-32 h-32 sm:w-36 sm:h-36 md:w-40 md:h-40 lg:w-44 lg:h-44 xl:w-48 xl:h-48 object-contain group-hover:opacity-90 transition-opacity"
                            />
                        </motion.div>
                    </Link>
                    
                    <nav className="space-y-1 flex-1 overflow-y-auto overflow-x-hidden pr-1 -mr-1 scrollbar-thin scrollbar-thumb-border scrollbar-track-transparent hover:scrollbar-thumb-border/50">
                        <motion.button onClick={handleOverviewTabDesktop} className={overviewClassDesktop} initial={{"opacity": 0, "x": -20}} animate={{"opacity": 1, "x": 0}} transition={{"delay": 0.03}} whileHover={{"x": 2}} whileTap={{"scale": 0.98}}>
                            {activeTab == "overview" && <motion.div layoutId="activeTab" className="absolute left-0 inset-y-1.5 w-0.5 bg-primary rounded-r-full" transition={{"type": "spring", "stiffness": 500, "damping": 30}} />}
                            <BarChart3 className={iconClassOverview} />
                            <span className="relative z-10">Overview</span>
                        </motion.button>
                        <motion.button onClick={handleResumeTabDesktop} className={resumeClassDesktop} initial={{"opacity": 0, "x": -20}} animate={{"opacity": 1, "x": 0}} transition={{"delay": 0.06}} whileHover={{"x": 2}} whileTap={{"scale": 0.98}}>
                            {activeTab == "resume" && <motion.div layoutId="activeTab" className="absolute left-0 inset-y-1.5 w-0.5 bg-primary rounded-r-full" transition={{"type": "spring", "stiffness": 500, "damping": 30}} />}
                            <FileText className={iconClassResume} />
                            <span className="relative z-10">Resume</span>
                        </motion.button>
                        <motion.button onClick={handleTargetsTabDesktop} className={targetsClassDesktop} initial={{"opacity": 0, "x": -20}} animate={{"opacity": 1, "x": 0}} transition={{"delay": 0.09}} whileHover={{"x": 2}} whileTap={{"scale": 0.98}}>
                            {activeTab == "targets" && <motion.div layoutId="activeTab" className="absolute left-0 inset-y-1.5 w-0.5 bg-primary rounded-r-full" transition={{"type": "spring", "stiffness": 500, "damping": 30}} />}
                            <Target className={iconClassTargets} />
                            <span className="relative z-10">Career Targets</span>
                        </motion.button>
                        <motion.button onClick={handleGapAnalysisTabDesktop} className={gapClassDesktop} initial={{"opacity": 0, "x": -20}} animate={{"opacity": 1, "x": 0}} transition={{"delay": 0.12}} whileHover={{"x": 2}} whileTap={{"scale": 0.98}}>
                            {activeTab == "gap-analysis" && <motion.div layoutId="activeTab" className="absolute left-0 inset-y-1.5 w-0.5 bg-primary rounded-r-full" transition={{"type": "spring", "stiffness": 500, "damping": 30}} />}
                            <TrendingUp className={iconClassGap} />
                            <span className="relative z-10">Skill Gap</span>
                        </motion.button>
                        <motion.button onClick={handleRoadmapTabDesktop} className={roadmapClassDesktop} initial={{"opacity": 0, "x": -20}} animate={{"opacity": 1, "x": 0}} transition={{"delay": 0.15}} whileHover={{"x": 2}} whileTap={{"scale": 0.98}}>
                            {activeTab == "roadmap" && <motion.div layoutId="activeTab" className="absolute left-0 inset-y-1.5 w-0.5 bg-primary rounded-r-full" transition={{"type": "spring", "stiffness": 500, "damping": 30}} />}
                            <BookOpen className={iconClassRoadmap} />
                            <span className="relative z-10">Learning Roadmap</span>
                        </motion.button>
                        <motion.button onClick={handleMarketTabDesktop} className={marketClassDesktop} initial={{"opacity": 0, "x": -20}} animate={{"opacity": 1, "x": 0}} transition={{"delay": 0.18}} whileHover={{"x": 2}} whileTap={{"scale": 0.98}}>
                            {activeTab == "market" && <motion.div layoutId="activeTab" className="absolute left-0 inset-y-1.5 w-0.5 bg-primary rounded-r-full" transition={{"type": "spring", "stiffness": 500, "damping": 30}} />}
                            <Network className={iconClassMarket} />
                            <span className="relative z-10">Market Intelligence</span>
                        </motion.button>
                        <motion.button onClick={handleProgressTabDesktop} className={progressClassDesktop} initial={{"opacity": 0, "x": -20}} animate={{"opacity": 1, "x": 0}} transition={{"delay": 0.21}} whileHover={{"x": 2}} whileTap={{"scale": 0.98}}>
                            {activeTab == "progress" && <motion.div layoutId="activeTab" className="absolute left-0 inset-y-1.5 w-0.5 bg-primary rounded-r-full" transition={{"type": "spring", "stiffness": 500, "damping": 30}} />}
                            <Sparkles className={iconClassProgress} />
                            <span className="relative z-10">Progress</span>
                        </motion.button>
                        <motion.button onClick={handleProfileTabDesktop} className={profileClassDesktop} initial={{"opacity": 0, "x": -20}} animate={{"opacity": 1, "x": 0}} transition={{"delay": 0.24}} whileHover={{"x": 2}} whileTap={{"scale": 0.98}}>
                            {activeTab == "profile" && <motion.div layoutId="activeTab" className="absolute left-0 inset-y-1.5 w-0.5 bg-primary rounded-r-full" transition={{"type": "spring", "stiffness": 500, "damping": 30}} />}
                            <User className={iconClassProfile} />
                            <span className="relative z-10">Profile</span>
                        </motion.button>
                    </nav>
                    
                    <div className="border-t border-border/50 pt-4 mt-auto shrink-0">
                        <motion.button
                            onClick={handleProfileTab}
                            whileHover={{"scale": 1.01}}
                            whileTap={{"scale": 0.99}}
                            className="flex items-center gap-3 mb-3 w-full p-2 rounded-lg hover:bg-secondary/50 transition-colors"
                        >
                            <div className="w-9 h-9 rounded-full bg-gradient-primary flex items-center justify-center overflow-hidden flex-shrink-0">
                                <span className="font-semibold text-primary-foreground text-xs">{userInfo["initials"]}</span>
                            </div>
                            <div className="flex-1 min-w-0 text-left">
                                <p className="font-medium text-foreground text-sm truncate">{userInfo["name"]}</p>
                                <p className="text-muted-foreground text-xs truncate">{userInfo["email"]}</p>
                            </div>
                        </motion.button>
                        <div className="flex gap-1.5">
                            <button 
                                onClick={handleProfileTab}
                                className="flex-1 h-8 w-8 rounded-lg hover:bg-secondary/50 transition-colors flex items-center justify-center"
                                title="Profile Settings"
                            >
                                <Settings className="w-4 h-4" />
                            </button>
                            <ThemeToggle />
                            <button 
                                onClick={handleLogout}
                                className="h-8 w-8 rounded-lg hover:bg-secondary/50 transition-colors flex items-center justify-center"
                                title="Logout"
                            >
                                <LogOut className="w-4 h-4" />
                            </button>
                        </div>
                    </div>
                </div>
            </aside>
            
            # Main Content - lg:ml-64 to sit beside fixed sidebar (match skill-navigator)
            <main className="lg:ml-64 min-h-screen bg-background">
                # Header
                <header className="sticky top-0 z-40 bg-background/95 backdrop-blur-xl border-b border-border/50">
                    <div className="flex items-center justify-between px-5 sm:px-6 lg:px-8 py-3.5">
                        <div className="flex items-center gap-3">
                            <button
                                onClick={toggleSidebar}
                                className="lg:hidden p-2 rounded-lg hover:bg-secondary/50 transition-colors"
                            >
                                {sidebarOpen and <X className="w-5 h-5" /> or <Menu className="w-5 h-5" />}
                            </button>
                            <div className="lg:hidden flex items-center gap-2.5">
                                <img 
                                    src="/static/assets/illustrations/logo.png"
                                    alt="Skillverse Logo"
                                    className="w-20 h-20 sm:w-24 sm:h-24 object-contain"
                                />
                            </div>
                            <h1 className="hidden lg:block font-display text-xl font-semibold text-foreground">Dashboard</h1>
                        </div>
                        <div className="flex items-center gap-2">
                            <button className="p-2 rounded-lg hover:bg-secondary/50 transition-colors relative">
                                <Bell className="w-5 h-5 text-muted-foreground" />
                                <span className="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full"></span>
                            </button>
                        </div>
                    </div>
                </header>
                
                # Dashboard Content - only active tab content is shown when a tab is clicked
                <div className="p-5 sm:p-6 lg:p-8 max-w-7xl mx-auto">
                    # Overview Tab
                    {activeTab == "overview" && (
                        <div className="space-y-5">
                            # Welcome Banner
                            <div className="relative rounded-xl overflow-hidden bg-gradient-primary">
                                <div className="absolute inset-0 bg-grid opacity-10" />
                                <div className="relative p-6 sm:p-8">
                                    <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                                        <div>
                                            <h2 className="font-display text-xl sm:text-2xl font-semibold text-primary-foreground mb-1.5">
                                                Welcome back, John
                                            </h2>
                                            <p className="text-primary-foreground/90 text-sm">
                                                You're 78% ready for your target role
                                            </p>
                                        </div>
                                        <button 
                                            onClick={lambda: setActiveTab("resume")}
                                            className="shrink-0 px-4 py-2 rounded-lg bg-white/10 hover:bg-white/20 text-primary-foreground border border-white/20 transition-all inline-flex items-center gap-2 text-sm font-medium"
                                        >
                                            <FontAwesomeIcon icon={faUpload} className="w-4 h-4 mr-2" />
                                            Update Resume
                                        </button>
                                    </div>
                                </div>
                            </div>
                            
                            # Stats Grid
                            <div className="grid grid-cols-2 lg:grid-cols-4 gap-3 sm:gap-4">
                                # Skills Tracked
                                <div className="p-4 sm:p-5 rounded-lg bg-card border border-border/50 hover:border-primary/30 transition-all">
                                    <div className="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center mb-3">
                                        <FontAwesomeIcon icon={faWandMagicSparkles} className="w-5 h-5 text-primary" />
                                    </div>
                                    <div className="flex items-baseline gap-2 mb-1">
                                        <p className="font-display text-xl sm:text-2xl font-semibold text-foreground">24</p>
                                        <span className="text-[10px] px-1.5 py-0.5 h-4 border-accent/30 text-accent bg-accent/5 rounded">+3</span>
                                    </div>
                                    <p className="text-muted-foreground text-xs">Skills Tracked</p>
                                </div>
                                
                                # Courses Active
                                <div className="p-4 sm:p-5 rounded-lg bg-card border border-border/50 hover:border-primary/30 transition-all">
                                    <div className="w-10 h-10 rounded-lg bg-accent/10 flex items-center justify-center mb-3">
                                        <FontAwesomeIcon icon={faBook} className="w-5 h-5 text-accent" />
                                    </div>
                                    <div className="flex items-baseline gap-2 mb-1">
                                        <p className="font-display text-xl sm:text-2xl font-semibold text-foreground">3</p>
                                        <span className="text-[10px] px-1.5 py-0.5 h-4 border-accent/30 text-accent bg-accent/5 rounded">+1</span>
                                    </div>
                                    <p className="text-muted-foreground text-xs">Courses Active</p>
                                </div>
                                
                                # Certifications
                                <div className="p-4 sm:p-5 rounded-lg bg-card border border-border/50 hover:border-primary/30 transition-all">
                                    <div className="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center mb-3">
                                        <FontAwesomeIcon icon={faAward} className="w-5 h-5 text-primary" />
                                    </div>
                                    <div className="flex items-baseline gap-2 mb-1">
                                        <p className="font-display text-xl sm:text-2xl font-semibold text-foreground">5</p>
                                        <span className="text-[10px] px-1.5 py-0.5 h-4 border-accent/30 text-accent bg-accent/5 rounded">+2</span>
                                    </div>
                                    <p className="text-muted-foreground text-xs">Certifications</p>
                                </div>
                                
                                # Career Score
                                <div className="p-4 sm:p-5 rounded-lg bg-card border border-border/50 hover:border-primary/30 transition-all">
                                    <div className="w-10 h-10 rounded-lg bg-accent/10 flex items-center justify-center mb-3">
                                        <FontAwesomeIcon icon={faChartLine} className="w-5 h-5 text-accent" />
                                    </div>
                                    <div className="flex items-baseline gap-2 mb-1">
                                        <p className="font-display text-xl sm:text-2xl font-semibold text-foreground">78%</p>
                                        <span className="text-[10px] px-1.5 py-0.5 h-4 border-accent/30 text-accent bg-accent/5 rounded">+5%</span>
                                    </div>
                                    <p className="text-muted-foreground text-xs">Career Score</p>
                                </div>
                            </div>
                            
                            # Career Graph Visualization
                            <div className="rounded-lg bg-card border border-border/50 overflow-hidden">
                                <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 p-4 sm:p-5 border-b border-border/50">
                                    <div className="flex items-center gap-3">
                                        <div className="w-9 h-9 rounded-lg bg-primary/10 flex items-center justify-center">
                                            <FontAwesomeIcon icon={faProjectDiagram} className="w-4 h-4 text-primary" />
                                        </div>
                                        <div>
                                            <h3 className="font-display text-base font-semibold text-foreground">Career Graph</h3>
                                            <p className="text-xs text-muted-foreground">Skill network visualization</p>
                                        </div>
                                    </div>
                                    <button 
                                        onClick={lambda: handleFullViewGraph()}
                                        className="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-lg text-xs font-semibold font-display transition-all duration-300 h-8 px-3 hover:bg-secondary/50 text-muted-foreground hover:text-foreground"
                                    >
                                        <FontAwesomeIcon icon={faMap} className="w-3.5 h-3.5 mr-1.5" />
                                        Full View
                                    </button>
                                </div>
                                <div className="h-[350px] sm:h-[450px] bg-secondary/20 p-4 relative" data-career-graph>
                                    <svg viewBox="0 0 1000 600" className="w-full h-full" preserveAspectRatio="xMidYMid meet" style={{"width": "100%", "height": "100%"}}>
                                        <defs>
                                            <linearGradient id="skillGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                                                <stop offset="0%" stopColor="hsl(250, 95%, 65%)" />
                                                <stop offset="100%" stopColor="hsl(180, 100%, 50%)" />
                                            </linearGradient>
                                            <linearGradient id="roleGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                                                <stop offset="0%" stopColor="hsl(280, 70%, 60%)" />
                                                <stop offset="100%" stopColor="hsl(300, 60%, 55%)" />
                                            </linearGradient>
                                            <linearGradient id="courseGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                                                <stop offset="0%" stopColor="hsl(150, 70%, 50%)" />
                                                <stop offset="100%" stopColor="hsl(140, 60%, 45%)" />
                                            </linearGradient>
                                            <pattern id="grid" width="50" height="50" patternUnits="userSpaceOnUse">
                                                <path d="M 50 0 L 0 0 0 50" fill="none" stroke="hsl(0, 0%, 30%)" strokeWidth="0.5" opacity="0.3" />
                                            </pattern>
                                        </defs>
                                        <rect width="1000" height="600" fill="url(#grid)" />
                                        <line x1="250" y1="240" x2="500" y2="180" stroke="hsl(250, 95%, 65%)" strokeWidth="2" strokeOpacity="0.3" strokeDasharray="5 5" />
                                        <line x1="400" y1="90" x2="250" y2="240" stroke="hsl(280, 70%, 60%)" strokeWidth="2.5" strokeOpacity="0.3" />
                                        <line x1="400" y1="90" x2="500" y2="180" stroke="hsl(280, 70%, 60%)" strokeWidth="2.5" strokeOpacity="0.3" />
                                        <line x1="750" y1="300" x2="800" y2="420" stroke="hsl(150, 70%, 50%)" strokeWidth="3" strokeOpacity="0.3" strokeDasharray="8 4" />
                                        <g>
                                            <circle cx="250" cy="240" r="20" fill="url(#skillGradient)" opacity="0.8" />
                                            <text x="250" y="250" textAnchor="middle" fontSize="12" fill="#e5e5e5" fontWeight="500">React</text>
                                            <text x="250" y="270" textAnchor="middle" fontSize="10" fill="#999999">85%</text>
                                        </g>
                                        <g>
                                            <circle cx="500" cy="180" r="18" fill="url(#skillGradient)" opacity="0.8" />
                                            <text x="500" y="190" textAnchor="middle" fontSize="12" fill="#e5e5e5" fontWeight="500">TypeScript</text>
                                            <text x="500" y="210" textAnchor="middle" fontSize="10" fill="#999999">78%</text>
                                        </g>
                                        <g>
                                            <circle cx="750" cy="300" r="16" fill="url(#skillGradient)" opacity="0.8" />
                                            <text x="750" y="310" textAnchor="middle" fontSize="12" fill="#e5e5e5" fontWeight="500">AWS</text>
                                            <text x="750" y="330" textAnchor="middle" fontSize="10" fill="#999999">45%</text>
                                        </g>
                                        <g>
                                            <circle cx="400" cy="90" r="22" fill="url(#roleGradient)" opacity="0.8" />
                                            <text x="400" y="100" textAnchor="middle" fontSize="12" fill="#e5e5e5" fontWeight="500">Senior FE</text>
                                            <text x="400" y="120" textAnchor="middle" fontSize="10" fill="#999999">78%</text>
                                        </g>
                                        <g>
                                            <circle cx="800" cy="420" r="18" fill="url(#courseGradient)" opacity="0.8" />
                                            <text x="800" y="430" textAnchor="middle" fontSize="12" fill="#e5e5e5" fontWeight="500">AWS Cert</text>
                                            <text x="800" y="450" textAnchor="middle" fontSize="10" fill="#999999">30%</text>
                                        </g>
                                    </svg>
                                </div>
                            </div>
                            
                            <div className="grid lg:grid-cols-3 gap-4">
                                # Skills Overview
                                <div className="lg:col-span-2 rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                    <div className="flex items-center justify-between mb-5">
                                        <div>
                                            <h3 className="font-display text-base font-semibold text-foreground">Your Skills</h3>
                                            <p className="text-xs text-muted-foreground mt-0.5">Track your skill progression</p>
                                        </div>
                                        <button 
                                            onClick={lambda: setShowAllSkills(not showAllSkills)}
                                            className="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-lg text-xs font-semibold font-display transition-all duration-300 h-7 px-3 hover:bg-secondary/50 text-muted-foreground hover:text-foreground"
                                        >
                                            {showAllSkills and "Show Less" or "View All"} <FontAwesomeIcon icon={faChevronRight} className="w-3.5 h-3.5 ml-1" />
                                        </button>
                                    </div>
                                    <div className="space-y-3">
                                        {skills.map(lambda skill: any, index: int -> any {
                                            # Determine progress bar color
                                            progressColor = "bg-primary/70";
                                            skillLevel = skill["level"];
                                            if skillLevel >= 80 {
                                                progressColor = "bg-accent";
                                            } else {
                                                if skillLevel >= 60 {
                                                    progressColor = "bg-primary";
                                                }
                                            }
                                            
                                            return <div key={index} className="group">
                                                <div className="flex items-center gap-3 mb-1.5">
                                                    <div className="flex items-center gap-2 min-w-0 flex-1">
                                                        <span className="text-sm font-medium text-foreground truncate">{skill["name"]}</span>
                                                        <span className="inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors text-foreground border-border/50 hidden sm:inline-flex">{skill["category"]}</span>
                                                    </div>
                                                    <span className="text-xs font-medium text-muted-foreground w-10 text-right">{skillLevel}%</span>
                                                </div>
                                                <div className="h-1.5 rounded-full bg-secondary overflow-hidden">
                                                    <div
                                                        className={"h-full rounded-full " + progressColor}
                                                        style={{"width": formatPercent(skillLevel) + "%"}}
                                                    />
                                                </div>
                                            </div>;
                                        })}
                                    </div>
                                </div>
                                
                                # Target Roles
                                <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                    <div className="flex items-center justify-between mb-5">
                                        <div>
                                            <h3 className="font-display text-base font-semibold text-foreground">Target Roles</h3>
                                            <p className="text-xs text-muted-foreground mt-0.5">Your career goals</p>
                                        </div>
                                        <button 
                                            onClick={lambda: setActiveTab("targets")}
                                            className="h-7 w-7 rounded-lg hover:bg-secondary/50 transition-colors flex items-center justify-center"
                                            title="Add Target Role"
                                        >
                                            <FontAwesomeIcon icon={faPlus} className="w-3.5 h-3.5" />
                                        </button>
                                    </div>
                                    <div className="space-y-2.5">
                                        {targetRoles.map(lambda role: any, index: int -> any {
                                            # Determine match color
                                            matchColor = "bg-primary/70";
                                            roleMatch = role["match"];
                                            if roleMatch >= 70 {
                                                matchColor = "bg-accent";
                                            } else {
                                                if roleMatch >= 50 {
                                                    matchColor = "bg-primary";
                                                }
                                            }
                                            
                                            return <div 
                                                key={index}
                                                onClick={lambda: setActiveTab("targets")}
                                                className="p-3 rounded-lg bg-secondary/30 hover:bg-secondary/50 border border-border/30 hover:border-primary/30 transition-all cursor-pointer group"
                                            >
                                                <div className="flex items-center justify-between mb-2">
                                                    <span className="font-medium text-foreground text-sm">{role["title"]}</span>
                                                    <FontAwesomeIcon icon={faArrowRight} className="w-3.5 h-3.5 text-muted-foreground group-hover:text-primary transition-colors" style={{"transform": "rotate(45deg)"}} />
                                                </div>
                                                <div className="flex items-center gap-2">
                                                    <div className="flex-1 h-1.5 rounded-full bg-background overflow-hidden">
                                                        <div
                                                            className={"h-full rounded-full " + matchColor}
                                                            style={{"width": formatPercent(roleMatch)}}
                                                        />
                                                    </div>
                                                    <span className="text-xs font-medium text-muted-foreground w-9 text-right">{roleMatch}%</span>
                                                </div>
                                            </div>;
                                        })}
                                    </div>
                                </div>
                            </div>
                            
                            # Learning Path
                            <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 mb-5">
                                    <div>
                                        <h3 className="font-display text-base font-semibold text-foreground">Learning Path</h3>
                                        <p className="text-xs text-muted-foreground mt-0.5">Your personalized learning journey</p>
                                    </div>
                                    <button 
                                        onClick={lambda: setActiveTab("roadmap")}
                                        className="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-lg text-xs font-semibold font-display transition-all duration-300 h-8 px-4 bg-primary text-primary-foreground hover:brightness-110 shadow-md hover:shadow-lg"
                                    >
                                        <FontAwesomeIcon icon={faWandMagicSparkles} className="w-3.5 h-3.5 mr-1.5" />
                                        Generate New
                                    </button>
                                </div>
                                <div className="grid sm:grid-cols-2 md:grid-cols-3 gap-3">
                                    {learningPath.map(lambda item: any, index: int -> any {
                                        # Determine progress color
                                        progressColor = "bg-primary/70";
                                        itemProgress = item["progress"];
                                        if itemProgress >= 75 {
                                            progressColor = "bg-accent";
                                        } else {
                                            if itemProgress >= 50 {
                                                progressColor = "bg-primary";
                                            }
                                        }
                                        
                                        # Check if completed
                                        showCheckIcon = itemProgress >= 75;
                                        
                                        return <div 
                                            key={index}
                                            onClick={lambda: setActiveTab("roadmap")}
                                            className="p-3.5 rounded-lg bg-secondary/30 hover:bg-secondary/50 border border-border/30 hover:border-primary/30 transition-all cursor-pointer"
                                        >
                                            <div className="flex items-center justify-between gap-2 mb-2.5">
                                                <span className="inline-flex items-center rounded-full border px-1.5 py-0.5 text-[10px] font-semibold transition-colors bg-primary/5 text-primary border-primary/20">{item["type"]}</span>
                                                {showCheckIcon and (
                                                    <FontAwesomeIcon icon={faCheckCircle} className="w-3.5 h-3.5 text-accent" />
                                                )}
                                            </div>
                                            <h4 className="font-medium text-foreground mb-2.5 text-sm">{item["title"]}</h4>
                                            <div className="flex items-center gap-2">
                                                <div className="flex-1 h-1.5 rounded-full bg-background overflow-hidden">
                                                    <div 
                                                        className={"h-full rounded-full " + progressColor}
                                                        style={{"width": formatPercent(itemProgress) + "%"}}
                                                    />
                                                </div>
                                                <span className="text-xs font-medium text-muted-foreground w-9 text-right">{itemProgress}%</span>
                                            </div>
                                        </div>;
                                    })}
                                </div>
                            </div>
                        </div>
                    )}
                    
                    # Resume Tab
                    {activeTab == "resume" && (
                        <div className="space-y-5 max-w-5xl mx-auto">
                            # Upload Section
                            <div className="rounded-lg bg-card border border-border/50 p-5 sm:p-6">
                                <div className="flex items-center gap-3 mb-5">
                                    <div className="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center">
                                        <FontAwesomeIcon icon={faFileText} className="w-5 h-5 text-primary" />
                                    </div>
                                    <div>
                                        <h3 className="font-display text-lg font-semibold text-foreground">Resume Upload</h3>
                                        <p className="text-xs text-muted-foreground mt-0.5">Upload your resume/CV for AI-powered extraction</p>
                                    </div>
                                </div>
                                
                                {not uploadedFile and (
                                    <div className="border-2 border-dashed border-primary/30 rounded-lg p-8 sm:p-10 text-center hover:border-primary/50 transition-colors bg-secondary/20">
                                        <input
                                            type="file"
                                            accept=".pdf,.doc,.docx"
                                            onChange={handleFileUpload}
                                            className="hidden"
                                            id="resume-upload"
                                            disabled={isUploading}
                                        />
                                        <label htmlFor="resume-upload" className="cursor-pointer">
                                            <div className="inline-flex flex-col items-center gap-4">
                                                <div className="w-16 h-16 sm:w-20 sm:h-20 rounded-full bg-primary/10 flex items-center justify-center">
                                                    <FontAwesomeIcon icon={faUpload} className="w-8 h-8 sm:w-10 sm:h-10 text-primary" />
                                                </div>
                                                <div>
                                                    <p className="font-medium text-foreground mb-1.5 text-sm sm:text-base">Click to upload or drag and drop</p>
                                                    <p className="text-xs text-muted-foreground">PDF, DOC, DOCX (Max 10MB)</p>
                                                </div>
                                                <button 
                                                    onClick={lambda: document.getElementById("resume-upload").click()}
                                                    className="mt-2 inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-xl text-sm font-semibold font-display transition-all duration-300 h-11 px-6 py-2 bg-primary text-primary-foreground hover:brightness-110 shadow-md hover:shadow-lg"
                                                >
                                                    Select File
                                                </button>
                                            </div>
                                        </label>
                                    </div>
                                )}
                                
                                {uploadedFile and (
                                    <div className="p-3.5 rounded-lg bg-secondary/30 border border-border/30 flex items-center justify-between">
                                        <div className="flex items-center gap-3">
                                            <FontAwesomeIcon icon={faFileText} className="w-4 h-4 text-primary" />
                                            <div>
                                                <p className="font-medium text-foreground text-sm">{uploadedFile["name"]}</p>
                                                <p className="text-xs text-muted-foreground">
                                                    {String((uploadedFile["size"] / 1024 / 1024).toFixed(2))} MB
                                                </p>
                                            </div>
                                        </div>
                                        <button 
                                            onClick={handleClearResume}
                                            className="h-8 w-8 rounded-lg hover:bg-secondary/50 transition-colors flex items-center justify-center"
                                        >
                                            <FontAwesomeIcon icon={faTimes} className="w-4 h-4" />
                                        </button>
                                    </div>
                                )}
                                
                                {(isUploading or isExtracting) and (
                                    <div className="mt-4 p-3.5 rounded-lg bg-primary/10 border border-primary/20 flex items-center gap-3">
                                        <FontAwesomeIcon icon={faSpinner} className="w-4 h-4 text-primary animate-spin" />
                                        <div>
                                            <p className="font-medium text-foreground text-sm">
                                                {isUploading and "Uploading..." or "Extracting data with byLLM..."}
                                            </p>
                                            <p className="text-xs text-muted-foreground">
                                                {isUploading and "Processing your file..." or "Analyzing skills, certifications, education, and experience..."}
                                            </p>
                                        </div>
                                    </div>
                                )}
                            </div>
                            
                            # Extracted Data Display
                            {extractedData and (
                                <div className="space-y-4">
                                    # Skills
                                    <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                        <div className="flex items-center gap-3 mb-4">
                                            <FontAwesomeIcon icon={faWandMagicSparkles} className="w-4 h-4 text-primary" />
                                            <h4 className="font-display text-base font-semibold text-foreground">Extracted Skills</h4>
                                            <span className="ml-auto inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors text-foreground">
                                                {String(extractedData["skills"].length)} skills
                                            </span>
                                        </div>
                                        <div className="flex flex-wrap gap-2">
                                            {extractedData["skills"].map(lambda skill: any, index: int -> any {
                                                return <span key={index} className="inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors bg-primary/10 text-primary border-primary/30">
                                                    <FontAwesomeIcon icon={faCheckCircle} className="w-3 h-3 mr-1" />
                                                    {skill}
                                                </span>;
                                            })}
                                        </div>
                                    </div>
                                    
                                    # Certifications
                                    <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                        <div className="flex items-center gap-3 mb-4">
                                            <FontAwesomeIcon icon={faAward} className="w-4 h-4 text-primary" />
                                            <h4 className="font-display text-base font-semibold text-foreground">Certifications</h4>
                                            <span className="ml-auto inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors text-foreground">
                                                {String(extractedData["certifications"].length)} found
                                            </span>
                                        </div>
                                        <div className="space-y-2">
                                            {extractedData["certifications"].map(lambda cert: any, index: int -> any {
                                                return <div key={index} className="p-3 rounded-lg bg-secondary/30 border border-border/30 flex items-center gap-2">
                                                    <FontAwesomeIcon icon={faAward} className="w-4 h-4 text-accent" />
                                                    <span className="text-sm font-medium text-foreground">{cert}</span>
                                                </div>;
                                            })}
                                        </div>
                                    </div>
                                    
                                    # Education
                                    <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                        <div className="flex items-center gap-3 mb-4">
                                            <FontAwesomeIcon icon={faGraduationCap} className="w-4 h-4 text-primary" />
                                            <h4 className="font-display text-base font-semibold text-foreground">Education</h4>
                                        </div>
                                        <div className="space-y-2.5">
                                            {extractedData["education"].map(lambda edu: any, index: int -> any {
                                                return <div key={index} className="p-3 rounded-lg bg-secondary/30 border border-border/30">
                                                    <p className="font-medium text-foreground text-sm">{edu["degree"]}</p>
                                                    <p className="text-xs text-muted-foreground">{edu["institution"]}</p>
                                                    <p className="text-xs text-muted-foreground mt-0.5">{edu["year"]}</p>
                                                </div>;
                                            })}
                                        </div>
                                    </div>
                                    
                                    # Experience
                                    <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                        <div className="flex items-center gap-3 mb-4">
                                            <FontAwesomeIcon icon={faBriefcase} className="w-4 h-4 text-primary" />
                                            <h4 className="font-display text-base font-semibold text-foreground">Experience</h4>
                                        </div>
                                        <div className="space-y-2.5">
                                            {extractedData["experience"].map(lambda exp: any, index: int -> any {
                                                return <div key={index} className="p-3 rounded-lg bg-secondary/30 border border-border/30">
                                                    <p className="font-medium text-foreground text-sm">{exp["role"]}</p>
                                                    <p className="text-xs text-muted-foreground">{exp["company"]}</p>
                                                    <p className="text-xs text-muted-foreground mt-0.5">{exp["duration"]}</p>
                                                </div>;
                                            })}
                                        </div>
                                    </div>
                                    
                                    # Success Message
                                    <div className="p-3.5 rounded-lg bg-accent/10 border border-accent/20 flex items-center gap-3">
                                        <FontAwesomeIcon icon={faCheckCircle} className="w-4 h-4 text-accent" />
                                        <div>
                                            <p className="font-medium text-foreground text-sm">Data extracted successfully!</p>
                                            <p className="text-xs text-muted-foreground">
                                                Your profile has been updated and stored in the OSP graph.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            )}
                        </div>
                    )}
                    
                    # Career Targets Tab
                    {activeTab == "targets" and (
                        <div className="space-y-6 max-w-6xl mx-auto">
                            # Selected Targets
                            {selectedTargets.length > 0 and (
                                <div className="p-6 sm:p-8 rounded-xl sm:rounded-2xl glass border border-border/50">
                                    <div className="flex items-center justify-between mb-4">
                                        <div className="flex items-center gap-3">
                                            <FontAwesomeIcon icon={faBullseye} className="w-5 h-5 text-primary" />
                                            <h3 className="font-display font-bold text-lg text-foreground">Selected Targets</h3>
                                            <span className="inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors text-foreground">
                                                {String(selectedTargets.length)} selected
                                            </span>
                                        </div>
                                    </div>
                                    <div className="flex flex-wrap gap-2">
                                        {selectedTargets.map(lambda target: any, index: int -> any {
                                            return <span key={index} className="group relative inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors pr-8 py-2 bg-primary/10 text-primary border-primary/30 text-sm">
                                                {target["title"]}
                                                <button
                                                    onClick={lambda: handleRemoveTarget(target["id"])}
                                                    className="absolute right-1 top-1/2 -translate-y-1/2 p-0.5 rounded hover:bg-primary/20"
                                                >
                                                    <FontAwesomeIcon icon={faTimes} className="w-3 h-3" />
                                                </button>
                                            </span>;
                                        })}
                                    </div>
                                </div>
                            )}
                            
                            # Search and Filter
                            <div className="p-6 sm:p-8 rounded-xl sm:rounded-2xl glass border border-border/50">
                                <div className="flex items-center gap-3 mb-6">
                                    <div className="w-10 h-10 rounded-xl bg-gradient-primary flex items-center justify-center shadow-glow">
                                        <FontAwesomeIcon icon={faWandMagicSparkles} className="w-5 h-5 text-primary-foreground" />
                                    </div>
                                    <div>
                                        <h3 className="font-display font-bold text-lg sm:text-xl text-foreground">Select Career Targets</h3>
                                        <p className="text-xs sm:text-sm text-muted-foreground mt-1">Choose roles, tracks, or skills. Data will be stored in your OSP graph for personalized analysis</p>
                                    </div>
                                </div>
                                
                                <div className="flex flex-col sm:flex-row gap-3 mb-4">
                                    <div className="relative flex-1">
                                        <FontAwesomeIcon icon={faSearch} className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                                        <input
                                            type="text"
                                            placeholder="Search roles, tracks, or skills..."
                                            value={searchQuery}
                                            onChange={handleSearchChange}
                                            className="w-full pl-10 pr-4 py-2 rounded-lg bg-background/50 border border-border text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-primary/20"
                                        />
                                    </div>
                                </div>
                                
                                # Category Filter
                                <div className="flex flex-wrap gap-2 mb-4">
                                    {[
                                        {"id": "all", "label": "All"},
                                        {"id": "role", "label": "Roles"},
                                        {"id": "track", "label": "Tracks"},
                                        {"id": "skill", "label": "Skills"}
                                    ].map(lambda cat: any -> any {
                                        isActive = activeCategory == cat["id"];
                                        return <button
                                            key={cat["id"]}
                                            onClick={lambda: handleCategoryChange(cat["id"])}
                                            className={isActive and "inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-lg text-xs font-semibold font-display transition-all duration-300 h-9 px-4 bg-primary text-primary-foreground hover:brightness-110 shadow-md hover:shadow-lg" or "inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-lg text-xs font-semibold font-display transition-all duration-300 h-9 px-4 border-2 border-border bg-transparent hover:bg-secondary text-foreground hover:border-primary/50"}
                                        >
                                            {cat["label"]}
                                        </button>;
                                    })}
                                </div>
                                
                                # Available Targets
                                <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
                                    {filteredTargets.map(lambda target: any, index: int -> any {
                                        matchColor = target["match"] >= 70 and "bg-gradient-accent" or "bg-gradient-primary";
                                        return <div
                                            key={target["id"]}
                                            onClick={lambda: handleSelectTarget(target)}
                                            className="p-5 sm:p-6 rounded-xl bg-secondary/50 border border-border/30 hover:border-primary/20 transition-all cursor-pointer group"
                                        >
                                            <div className="flex items-start justify-between mb-3">
                                                <div className="flex-1">
                                                    <h4 className="font-medium text-foreground mb-1 group-hover:text-primary transition-colors">
                                                        {target["title"]}
                                                    </h4>
                                                    <span className="inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors text-[10px] px-1.5 py-0.5 capitalize text-foreground">
                                                        {target["category"]}
                                                    </span>
                                                </div>
                                                <FontAwesomeIcon icon={faPlus} className="w-4 h-4 text-muted-foreground group-hover:text-primary transition-colors" />
                                            </div>
                                            
                                            <div className="space-y-2">
                                                <div className="flex items-center justify-between">
                                                    <span className="text-xs text-muted-foreground">Match</span>
                                                    <span className="text-sm font-medium text-foreground">{String(target["match"])}%</span>
                                                </div>
                                                <div className="h-1.5 rounded-full bg-background overflow-hidden">
                                                    <div
                                                        className={"h-full rounded-full " + matchColor}
                                                        style={{"width": formatPercent(target["match"])}}
                                                    />
                                                </div>
                                                
                                                <div className="flex items-center justify-between pt-2 border-t border-border/30">
                                                    <span className={"inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors text-[10px] px-1.5 py-0.5 " + getDemandColor(target["demand"])}>
                                                        {target["demand"]} demand
                                                    </span>
                                                    <div className="flex items-center gap-1 text-xs text-muted-foreground">
                                                        <FontAwesomeIcon icon={faArrowUp} className="w-3 h-3 text-accent" />
                                                        <span>+{String(target["growth"])}%</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>;
                                    })}
                                </div>
                                
                                {filteredTargets.length == 0 and (
                                    <div className="text-center py-12 sm:py-16">
                                        <div className="w-16 h-16 mx-auto mb-4 rounded-full bg-secondary/50 flex items-center justify-center">
                                            <FontAwesomeIcon icon={faBullseye} className="w-8 h-8 text-muted-foreground" />
                                        </div>
                                        <p className="text-muted-foreground text-sm sm:text-base">No targets found. Try a different search or category.</p>
                                    </div>
                                )}
                            </div>
                            
                            # Action Button
                            {selectedTargets.length > 0 and (
                                <div className="flex justify-end pt-4">
                                    <button
                                        onClick={handleNavigateToGapAnalysis}
                                        className="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-xl text-sm font-semibold font-display transition-all duration-300 h-12 px-8 bg-gradient-primary text-primary-foreground hover:opacity-90 shadow-lg shadow-primary/20"
                                    >
                                        Analyze Skill Gaps
                                        <FontAwesomeIcon icon={faArrowRight} className="w-5 h-5 ml-2" />
                                    </button>
                                </div>
                            )}
                        </div>
                    )}
                    
                    # Skill Gap Analysis Tab
                    {activeTab == "gap-analysis" and (
                        <div className="space-y-5 max-w-6xl mx-auto">
                            # Analysis Process
                            {isAnalyzing and (
                                <div className="rounded-lg bg-card border border-primary/20 bg-primary/5 p-5 sm:p-6">
                                    <div className="flex items-center gap-3 mb-4">
                                        <FontAwesomeIcon icon={faCircleNotch} className="w-6 h-6 text-primary animate-spin" />
                                        <div className="flex-1">
                                            <h3 className="font-display text-base font-semibold text-foreground mb-1">Analyzing Skill Gaps</h3>
                                            <p className="text-xs text-muted-foreground">byLLM AI is comparing your skills with target role requirements...</p>
                                        </div>
                                    </div>
                                    <div className="space-y-2">
                                        <div className="flex items-center justify-between text-xs">
                                            <span className="text-muted-foreground">Progress</span>
                                            <span className="font-medium text-foreground">{String(analysisProgress)}%</span>
                                        </div>
                                        <div className="h-2 rounded-full bg-secondary overflow-hidden">
                                            <div
                                                className="h-full bg-primary rounded-full"
                                                style={{"width": formatPercent(analysisProgress)}}
                                            />
                                        </div>
                                        <div className="flex items-center gap-2 text-xs text-muted-foreground mt-2">
                                            <FontAwesomeIcon icon={faWandMagicSparkles} className="w-3 h-3" />
                                            <span>Identifying missing skills...</span>
                                        </div>
                                    </div>
                                </div>
                            )}
                            
                            {not isAnalyzing and not showResults and (
                                <div className="rounded-lg bg-card border border-border/50 p-6 sm:p-8 text-center">
                                    <div className="flex flex-col items-center gap-4">
                                        <div className="w-14 h-14 rounded-full bg-primary/10 flex items-center justify-center">
                                            <FontAwesomeIcon icon={faBarChart} className="w-7 h-7 text-primary" />
                                        </div>
                                        <div>
                                            <h3 className="font-display text-lg font-semibold text-foreground mb-2">Ready to Analyze</h3>
                                            <p className="text-sm text-muted-foreground mb-4">Get insights into your skill gaps and prioritize your learning</p>
                                            <button
                                                onClick={startAnalysis}
                                                className="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-xl text-sm font-semibold font-display transition-all duration-300 h-11 px-6 py-2 bg-primary text-primary-foreground hover:brightness-110 shadow-md hover:shadow-lg"
                                            >
                                                <FontAwesomeIcon icon={faWandMagicSparkles} className="w-4 h-4 mr-2" />
                                                Start Analysis
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            )}
                            
                            {showResults and (
                                <div className="space-y-6">
                                    # Summary Cards
                                    <div className="grid sm:grid-cols-3 gap-4">
                                        <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                            <div className="flex items-center gap-3 mb-3">
                                                <div className="w-9 h-9 rounded-lg bg-red-500/20 flex items-center justify-center">
                                                    <FontAwesomeIcon icon={faExclamationCircle} className="w-4 h-4 text-red-400" />
                                                </div>
                                                <h4 className="font-display text-sm font-semibold text-foreground">High Priority</h4>
                                            </div>
                                            <p className="text-xl sm:text-2xl font-semibold text-foreground mb-1">{String(highPriorityGaps.length)}</p>
                                            <p className="text-xs text-muted-foreground">Critical skills to develop</p>
                                        </div>
                                        
                                        <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                            <div className="flex items-center gap-3 mb-3">
                                                <div className="w-9 h-9 rounded-lg bg-primary/20 flex items-center justify-center">
                                                    <FontAwesomeIcon icon={faBarChart} className="w-4 h-4 text-primary" />
                                                </div>
                                                <h4 className="font-display text-sm font-semibold text-foreground">Average Gap</h4>
                                            </div>
                                            <p className="text-xl sm:text-2xl font-semibold text-foreground mb-1">{String(avgGap)}%</p>
                                            <p className="text-xs text-muted-foreground">Across all skills</p>
                                        </div>
                                        
                                        <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                            <div className="flex items-center gap-3 mb-3">
                                                <div className="w-9 h-9 rounded-lg bg-accent/20 flex items-center justify-center">
                                                    <FontAwesomeIcon icon={faBullseye} className="w-4 h-4 text-accent" />
                                                </div>
                                                <h4 className="font-display text-sm font-semibold text-foreground">Skills Analyzed</h4>
                                            </div>
                                            <p className="text-xl sm:text-2xl font-semibold text-foreground mb-1">{String(skillGaps.length)}</p>
                                            <p className="text-xs text-muted-foreground">Total gaps identified</p>
                                        </div>
                                    </div>
                                    
                                    # Skill Gap Details
                                    <div className="rounded-lg bg-card border border-border/50 p-5 sm:p-6">
                                        <div className="flex items-center gap-3 mb-5">
                                            <div className="w-9 h-9 rounded-lg bg-primary/10 flex items-center justify-center">
                                                <FontAwesomeIcon icon={faBullseye} className="w-4 h-4 text-primary" />
                                            </div>
                                            <div>
                                                <h3 className="font-display text-base font-semibold text-foreground">Detailed Gap Analysis</h3>
                                                <p className="text-xs text-muted-foreground mt-0.5">Compare your skills with target requirements</p>
                                            </div>
                                        </div>
                                        
                                        <div className="space-y-3">
                                            {skillGaps.map(lambda gap: any, index: int -> any {
                                                return <div key={index} className="p-4 rounded-lg bg-secondary/30 border border-border/30 hover:border-primary/30 transition-all">
                                                    <div className="flex items-start justify-between mb-4">
                                                        <div className="flex-1">
                                                            <div className="flex items-center gap-2 mb-2">
                                                                <h4 className="font-medium text-foreground">{gap["skill"]}</h4>
                                                                <span className="inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors text-[10px] px-1.5 py-0.5">
                                                                    {gap["category"]}
                                                                </span>
                                                                <span className={"inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors text-[10px] px-1.5 py-0.5 " + getPriorityColor(gap["priority"])}>
                                                                    {gap["priority"]} priority
                                                                </span>
                                                            </div>
                                                            <div className="flex items-center gap-4 text-sm text-muted-foreground">
                                                                <span>Current: {String(gap["currentLevel"])}%</span>
                                                                <span>Required: {String(gap["requiredLevel"])}%</span>
                                                                <span className="text-red-400 font-medium">Gap: {String(gap["gap"])}%</span>
                                                            </div>
                                                        </div>
                                                        <div className="text-right">
                                                            <div className="flex items-center gap-1 text-xs text-muted-foreground mb-1">
                                                                <FontAwesomeIcon icon={faArrowUp} className="w-3 h-3 text-accent" />
                                                                <span>Market Demand</span>
                                                            </div>
                                                            <p className="text-lg font-bold text-accent">{String(gap["marketDemand"])}%</p>
                                                        </div>
                                                    </div>
                                                    
                                                    # Progress Bars
                                                    <div className="space-y-2">
                                                        <div>
                                                            <div className="flex items-center justify-between mb-1">
                                                                <span className="text-xs text-muted-foreground">Current Level</span>
                                                                <span className="text-xs font-medium text-foreground">{String(gap["currentLevel"])}%</span>
                                                            </div>
                                                            <div className="h-1.5 rounded-full bg-background overflow-hidden">
                                                                <div
                                                                    className="h-full bg-primary rounded-full"
                                                                    style={{"width": formatPercent(gap["currentLevel"]) + "%"}}
                                                                />
                                                            </div>
                                                        </div>
                                                        
                                                        <div>
                                                            <div className="flex items-center justify-between mb-1">
                                                                <span className="text-xs text-muted-foreground">Required Level</span>
                                                                <span className="text-xs font-medium text-foreground">{String(gap["requiredLevel"])}%</span>
                                                            </div>
                                                            <div className="h-1.5 rounded-full bg-background overflow-hidden">
                                                                <div
                                                                    className="h-full bg-accent rounded-full"
                                                                    style={{"width": formatPercent(gap["requiredLevel"]) + "%"}}
                                                                />
                                                            </div>
                                                        </div>
                                                        
                                                        <div>
                                                            <div className="flex items-center justify-between mb-1">
                                                                <span className="text-xs text-muted-foreground">Gap to Close</span>
                                                                <span className="text-xs font-medium text-red-400">{String(gap["gap"])}%</span>
                                                            </div>
                                                            <div className="h-1.5 rounded-full bg-background overflow-hidden">
                                                                <div
                                                                    className="h-full bg-red-500 rounded-full"
                                                                    style={{"width": formatPercent(gap["gap"]) + "%"}}
                                                                />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    # Market Demand Indicator
                                                    <div className="mt-3 pt-3 border-t border-border/30 flex items-center gap-2">
                                                        <div className="flex-1">
                                                            <div className="flex items-center justify-between mb-1">
                                                                <span className="text-xs text-muted-foreground">Market Demand</span>
                                                                <span className="text-xs font-medium text-accent">{String(gap["marketDemand"])}%</span>
                                                            </div>
                                                            <div className="h-1.5 rounded-full bg-background overflow-hidden">
                                                                <div
                                                                    className="h-full bg-accent rounded-full"
                                                                    style={{"width": formatPercent(gap["marketDemand"]) + "%"}}
                                                                />
                                                            </div>
                                                        </div>
                                                        {gap["marketDemand"] >= 85 and (
                                                            <span className="inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors text-[10px] px-1.5 py-0.5 bg-accent/10 text-accent border-accent/30">
                                                                <FontAwesomeIcon icon={faArrowUp} className="w-3 h-3 mr-1" />
                                                                Hot
                                                            </span>
                                                        )}
                                                    </div>
                                                </div>;
                                            })}
                                        </div>
                                    </div>
                                    
                                    # Insights
                                    <div className="rounded-lg bg-card border border-primary/20 bg-primary/5 p-4 sm:p-5">
                                        <div className="flex items-start gap-3">
                                            <FontAwesomeIcon icon={faCheckCircle} className="w-4 h-4 text-primary mt-0.5" />
                                            <div>
                                                <h4 className="font-display text-sm font-semibold text-foreground mb-2">byLLM Analysis Insights</h4>
                                                <p className="text-xs text-muted-foreground mb-3">Powered by byLLM AI comparing your skills with target role requirements</p>
                                                <ul className="space-y-1.5 text-xs text-muted-foreground">
                                                    <li className="flex items-start gap-2">
                                                        <span className="text-primary mt-1">•</span>
                                                        <span>
                                                            Focus on <strong>System Design</strong> and <strong>AWS Cloud</strong> first - highest market demand
                                                        </span>
                                                    </li>
                                                    <li className="flex items-start gap-2">
                                                        <span className="text-primary mt-1">•</span>
                                                        <span>
                                                            Your <strong>Leadership</strong> skills are close to target - prioritize technical gaps
                                                        </span>
                                                    </li>
                                                    <li className="flex items-start gap-2">
                                                        <span className="text-primary mt-1">•</span>
                                                        <span>
                                                            <strong>Kubernetes</strong> shows 35% growth - emerging skill with high ROI
                                                        </span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            )}
                        </div>
                    )}
                    
                    # Learning Roadmap Tab
                    {activeTab == "roadmap" and (
                        <div className="space-y-5 max-w-6xl mx-auto">
                            # Stats
                            <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-4">
                                <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                    <div className="flex items-center gap-2 mb-2">
                                        <div className="w-8 h-8 rounded-lg bg-primary/20 flex items-center justify-center">
                                            <FontAwesomeIcon icon={faBook} className="w-4 h-4 text-primary" />
                                        </div>
                                        <p className="text-xs text-muted-foreground">Total Items</p>
                                    </div>
                                    <p className="text-xl sm:text-2xl font-semibold text-foreground">{String(totalItems)}</p>
                                </div>
                                
                                <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                    <div className="flex items-center gap-2 mb-2">
                                        <div className="w-8 h-8 rounded-lg bg-accent/20 flex items-center justify-center">
                                            <FontAwesomeIcon icon={faPlay} className="w-4 h-4 text-accent" />
                                        </div>
                                        <p className="text-xs text-muted-foreground">In Progress</p>
                                    </div>
                                    <p className="text-xl sm:text-2xl font-semibold text-foreground">{String(inProgressItems.length)}</p>
                                </div>
                                
                                <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                    <div className="flex items-center gap-2 mb-2">
                                        <div className="w-8 h-8 rounded-lg bg-green-500/20 flex items-center justify-center">
                                            <FontAwesomeIcon icon={faCheckCircle} className="w-4 h-4 text-green-400" />
                                        </div>
                                        <p className="text-xs text-muted-foreground">Completed</p>
                                    </div>
                                    <p className="text-xl sm:text-2xl font-semibold text-foreground">{String(completedItems.length)}</p>
                                </div>
                                
                                <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                    <div className="flex items-center gap-2 mb-2">
                                        <div className="w-8 h-8 rounded-lg bg-primary/20 flex items-center justify-center">
                                            <FontAwesomeIcon icon={faWandMagicSparkles} className="w-4 h-4 text-primary" />
                                        </div>
                                        <p className="text-xs text-muted-foreground">Avg Progress</p>
                                    </div>
                                    <p className="text-xl sm:text-2xl font-semibold text-foreground">{String(avgProgress)}%</p>
                                </div>
                            </div>
                            
                            # Filters
                            <div className="flex flex-wrap gap-2">
                                {[
                                    {"id": "all", "label": "All Items"},
                                    {"id": "high", "label": "High Priority"},
                                    {"id": "in-progress", "label": "In Progress"}
                                ].map(lambda filter: any -> any {
                                    isActive = selectedFilter == filter["id"];
                                    return <button
                                        key={filter["id"]}
                                        onClick={lambda: handleFilterChange(filter["id"])}
                                        className={isActive and "inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-lg text-xs font-semibold font-display transition-all duration-300 h-9 px-4 bg-primary text-primary-foreground hover:brightness-110 shadow-md hover:shadow-lg" or "inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-lg text-xs font-semibold font-display transition-all duration-300 h-9 px-4 border-2 border-border bg-transparent hover:bg-secondary text-foreground hover:border-primary/50"}
                                    >
                                        {filter["label"]}
                                    </button>;
                                })}
                            </div>
                            
                            # Roadmap Items
                            <div className="space-y-3">
                                {filteredRoadmapItems.map(lambda item: dict, index: int -> any { return renderRoadmapItem({"item": item}); })}
                            </div>
                            
                            # Generate New Roadmap
                            <div className="rounded-xl sm:rounded-2xl glass border border-primary/20 bg-primary/5 p-4 sm:p-5">
                                {roadmapGenerateBlock}
                            </div>
                        </div>
                    )}
                    
                    # Market Intelligence Tab
                    {activeTab == "market" and (
                        <div className="space-y-6 max-w-6xl mx-auto">
                            # Alerts Section
                            <div className="p-6 sm:p-8 rounded-xl sm:rounded-2xl glass border border-border/50">
                                <div className="flex items-center gap-3 mb-6">
                                    <div className="w-10 h-10 rounded-xl bg-gradient-primary flex items-center justify-center shadow-glow">
                                        <FontAwesomeIcon icon={faBell} className="w-5 h-5 text-primary-foreground" />
                                    </div>
                                    <div className="flex-1">
                                        <h3 className="font-display font-bold text-lg sm:text-xl text-foreground">Market Alerts</h3>
                                        <p className="text-xs sm:text-sm text-muted-foreground mt-1">Real-time notifications about market changes</p>
                                    </div>
                                    <span className="inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors bg-accent/10 text-accent border-accent/30">
                                        {String(marketAlerts.length)} new
                                    </span>
                                </div>
                                
                                <div className="space-y-3">
                                    {marketAlerts.map(lambda alert: any, index: int -> any {
                                        alertColor = getAlertColor(alert["type"]);
                                        return <div key={alert["id"]} className={"p-4 rounded-xl border " + alertColor}>
                                            <div className="flex items-start justify-between">
                                                <div className="flex-1">
                                                    <div className="flex items-center gap-2 mb-1">
                                                        <FontAwesomeIcon icon={faExclamationCircle} className="w-4 h-4" />
                                                        <h4 className="font-medium text-foreground">{alert["title"]}</h4>
                                                        {"skill" in alert and alert["skill"] and (
                                                            <span className="inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors text-[10px] px-1.5 py-0.5">
                                                                {alert["skill"]}
                                                            </span>
                                                        )}
                                                    </div>
                                                    <p className="text-sm text-muted-foreground mb-2">{alert["description"]}</p>
                                                    <p className="text-xs text-muted-foreground">{alert["timestamp"]}</p>
                                                </div>
                                            </div>
                                        </div>;
                                    })}
                                </div>
                            </div>
                            
                            # Market Trends
                            <div className="p-6 sm:p-8 rounded-xl sm:rounded-2xl glass border border-border/50">
                                <div className="flex items-center gap-3 mb-6">
                                    <div className="w-10 h-10 rounded-xl bg-gradient-primary flex items-center justify-center shadow-glow">
                                        <FontAwesomeIcon icon={faBarChart} className="w-5 h-5 text-primary-foreground" />
                                    </div>
                                    <div>
                                        <h3 className="font-display font-bold text-lg sm:text-xl text-foreground">Real-Time Market Trends</h3>
                                        <p className="text-xs sm:text-sm text-muted-foreground mt-1">Live job market data and skill demand</p>
                                    </div>
                                </div>
                                
                                <div className="space-y-4">
                                    {marketTrends.map(lambda trend: any, index: int -> any {
                                        trendIcon = getTrendIcon(trend["trend"]);
                                        return <div key={trend["skill"]} className="p-5 rounded-xl bg-secondary/50 border border-border/30 hover:border-primary/20 transition-all">
                                            <div className="flex items-start justify-between mb-4">
                                                <div className="flex-1">
                                                    <div className="flex items-center gap-2 mb-2">
                                                        <h4 className="font-medium text-foreground">{trend["skill"]}</h4>
                                                        <span className="inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors text-[10px] px-1.5 py-0.5">
                                                            {trend["category"]}
                                                        </span>
                                                    </div>
                                                    <div className="flex items-center gap-4 text-sm text-muted-foreground">
                                                        <span>Demand: {String(trend["currentDemand"])}%</span>
                                                        <span className={trend["change"] >= 0 and "text-accent" or "text-red-400"}>
                                                            {trend["change"] >= 0 and "+" or ""}{String(trend["change"])}%
                                                        </span>
                                                    </div>
                                                </div>
                                                <div className="text-right">
                                                    <div className="flex items-center gap-1 text-xs text-muted-foreground mb-1">
                                                        {trendIcon and (
                                                            <FontAwesomeIcon icon={trendIcon} className="w-3 h-3" />
                                                        )}
                                                        <span>Growth</span>
                                                    </div>
                                                    <p className="text-lg font-bold text-accent">+{String(trend["growth"])}%</p>
                                                </div>
                                            </div>
                                            <div className="h-1.5 rounded-full bg-background overflow-hidden">
                                                <div
                                                    className={trend["trend"] == "up" and "h-full rounded-full bg-accent" or trend["trend"] == "down" and "h-full rounded-full bg-red-500" or "h-full rounded-full bg-muted-foreground"}
                                                    style={{"width": formatPercent(trend["currentDemand"])}}
                                                />
                                            </div>
                                        </div>;
                                    })}
                                </div>
                            </div>
                        </div>
                    )}
                    
                    # Progress Tracking Tab
                    {activeTab == "progress" and (
                        <div className="space-y-6 max-w-6xl mx-auto">
                            # Summary Stats
                            <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-6">
                                <div className="p-5 sm:p-6 rounded-xl sm:rounded-2xl glass border border-border/50">
                                    <div className="flex items-center gap-2 mb-2">
                                        <div className="w-8 h-8 rounded-lg bg-primary/20 flex items-center justify-center">
                                            <FontAwesomeIcon icon={faBarChart} className="w-4 h-4 text-primary" />
                                        </div>
                                        <p className="text-xs sm:text-sm text-muted-foreground">Overall Progress</p>
                                    </div>
                                    <p className="text-2xl sm:text-3xl font-bold text-foreground">{String(totalProgress)}%</p>
                                </div>
                                
                                <div className="p-5 sm:p-6 rounded-xl sm:rounded-2xl glass border border-border/50">
                                    <div className="flex items-center gap-2 mb-2">
                                        <div className="w-8 h-8 rounded-lg bg-green-500/20 flex items-center justify-center">
                                            <FontAwesomeIcon icon={faCheckCircle} className="w-4 h-4 text-green-400" />
                                        </div>
                                        <p className="text-xs sm:text-sm text-muted-foreground">Completed</p>
                                    </div>
                                    <p className="text-2xl sm:text-3xl font-bold text-foreground">{String(completedProgressCount.length)}</p>
                                </div>
                                
                                <div className="p-5 sm:p-6 rounded-xl sm:rounded-2xl glass border border-border/50">
                                    <div className="flex items-center gap-2 mb-2">
                                        <div className="w-8 h-8 rounded-lg bg-accent/20 flex items-center justify-center">
                                            <FontAwesomeIcon icon={faArrowUp} className="w-4 h-4 text-accent" />
                                        </div>
                                        <p className="text-xs sm:text-sm text-muted-foreground">In Progress</p>
                                    </div>
                                    <p className="text-2xl sm:text-3xl font-bold text-foreground">{String(inProgressProgressCount.length)}</p>
                                </div>
                                
                                <div className="p-5 sm:p-6 rounded-xl sm:rounded-2xl glass border border-border/50">
                                    <div className="flex items-center gap-2 mb-2">
                                        <div className="w-8 h-8 rounded-lg bg-primary/20 flex items-center justify-center">
                                            <FontAwesomeIcon icon={faBullseye} className="w-4 h-4 text-primary" />
                                        </div>
                                        <p className="text-xs sm:text-sm text-muted-foreground">Total Items</p>
                                    </div>
                                    <p className="text-2xl sm:text-3xl font-bold text-foreground">{String(progressItems.length)}</p>
                                </div>
                            </div>
                            
                            # Progress Items - glass section matching skill-navigator
                            <div className="p-6 sm:p-8 rounded-xl sm:rounded-2xl glass border border-border/50">
                                <div className="flex items-center gap-3 mb-6">
                                    <div className="w-10 h-10 rounded-xl bg-gradient-primary flex items-center justify-center shadow-glow">
                                        <FontAwesomeIcon icon={faBullseye} className="w-5 h-5 text-primary-foreground" />
                                    </div>
                                    <div>
                                        <h3 className="font-display font-bold text-lg sm:text-xl text-foreground">Track Your Progress</h3>
                                        <p className="text-xs sm:text-sm text-muted-foreground mt-1">Monitor your learning journey</p>
                                    </div>
                                </div>
                                <div className="space-y-4 sm:space-y-6">
                                {progressItems.map(lambda item: any, index: int -> any {
                                    typeIcon = getProgressTypeIcon(item["type"]);
                                    typeColor = getProgressTypeColor(item["type"]);
                                    progressPercent = truncToInt((truncToInt(item["progress"]) / truncToInt(item["target"])) * 100);
                                    
                                    return <div key={item["id"]} className="p-5 sm:p-6 rounded-xl bg-secondary/50 border border-border/30 hover:border-primary/20 transition-all">
                                        <div className="flex items-start justify-between mb-4">
                                            <div className="flex items-start gap-4 flex-1">
                                                <div className={item["status"] == "completed" and "w-12 h-12 rounded-xl flex items-center justify-center bg-green-500/20 border-2 border-green-500/30" or item["status"] == "in-progress" and "w-12 h-12 rounded-xl flex items-center justify-center bg-primary/20 border-2 border-primary/30" or "w-12 h-12 rounded-xl flex items-center justify-center bg-secondary border-2 border-border"}>
                                                    <FontAwesomeIcon icon={typeIcon} className={item["status"] == "completed" and "w-6 h-6 text-green-400" or item["status"] == "in-progress" and "w-6 h-6 text-primary" or "w-6 h-6 text-muted-foreground"} />
                                                </div>
                                                <div className="flex-1">
                                                    <div className="flex items-center gap-2 mb-2">
                                                        <h4 className="font-display font-bold text-lg text-foreground">{item["title"]}</h4>
                                                        {item["status"] == "completed" and (
                                                            <FontAwesomeIcon icon={faCheckCircle} className="w-5 h-5 text-green-400" />
                                                        )}
                                                    </div>
                                                    <div className="flex flex-wrap items-center gap-2 mb-2">
                                                        <span className={"inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors " + typeColor}>
                                                            {item["type"]}
                                                        </span>
                                                        {"category" in item and item["category"] and (
                                                            <span className="inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors text-[10px] px-1.5 py-0.5">
                                                                {item["category"]}
                                                            </span>
                                                        )}
                                                    </div>
                                                    <div className="flex items-center gap-4 text-sm text-muted-foreground">
                                                        <span>Progress: {String(item["progress"])}/{String(item["target"])}</span>
                                                        {"completedDate" in item and item["completedDate"] and (
                                                            <span>Completed: {item["completedDate"]}</span>
                                                        )}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        # Progress Bar - matching skill-navigator
                                        <div className="mb-3">
                                            <div className="flex items-center justify-between mb-1.5">
                                                <span className="text-xs text-muted-foreground">Current Progress</span>
                                                <span className="text-xs font-medium text-foreground">{String(progressPercent)}%</span>
                                            </div>
                                            <div className="h-1.5 rounded-full bg-background overflow-hidden">
                                                <div
                                                    className={item["progress"] >= 75 and "h-full rounded-full bg-accent" or item["progress"] >= 50 and "h-full rounded-full bg-primary" or "h-full rounded-full bg-primary/70"}
                                                    style={{"width": formatPercent(progressPercent)}}
                                                />
                                            </div>
                                        </div>
                                    </div>;
                                })}
                                </div>
                            </div>
                            # Real-Time Updates notice - matching skill-navigator
                            <div className="p-6 rounded-2xl glass border border-primary/20 bg-primary/5">
                                <div className="flex items-start gap-3">
                                    <FontAwesomeIcon icon={faWandMagicSparkles} className="w-5 h-5 text-primary mt-0.5" />
                                    <div>
                                        <h4 className="font-display font-bold text-foreground mb-1">Real-Time Updates</h4>
                                        <p className="text-sm text-muted-foreground">
                                            Your career graph automatically updates as you complete skills, courses, and certifications. Progress is tracked in real-time and reflected in your OSP graph. byLLM AI continuously analyzes your progress to provide personalized recommendations.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    )}
                    
                    # Profile Tab
                    {activeTab == "profile" and (
                        <div className="space-y-5 max-w-6xl mx-auto">
                            # Profile Header
                            <div className="rounded-lg bg-card border border-border/50 p-5 sm:p-6">
                                <div className="flex flex-col md:flex-row gap-5 md:items-start">
                                    # Avatar Section
                                    <div className="flex-shrink-0">
                                        <div className="relative">
                                            <div className="w-20 h-20 sm:w-24 sm:h-24 rounded-full bg-primary/10 flex items-center justify-center overflow-hidden border-2 border-border">
                                                {(avatarPreview or ("avatar" in profileData and profileData["avatar"])) and (
                                                    <img
                                                        src={avatarPreview or profileData["avatar"]}
                                                        alt={profileData["name"]}
                                                        className="w-full h-full object-cover"
                                                    />
                                                ) or (
                                                    <span className="font-semibold text-primary text-xl sm:text-2xl">
                                                        {userInfo["initials"]}
                                                    </span>
                                                )}
                                            </div>
                                            {isEditing and (
                                                <label className="absolute bottom-0 right-0 w-8 h-8 rounded-full bg-primary flex items-center justify-center cursor-pointer hover:bg-primary/90 transition-colors shadow-md z-10">
                                                    <FontAwesomeIcon icon={faCamera} className="w-4 h-4 text-primary-foreground" />
                                                    <input
                                                        type="file"
                                                        accept="image/*"
                                                        onChange={handleAvatarChange}
                                                        className="hidden"
                                                    />
                                                </label>
                                            )}
                                        </div>
                                    </div>
                                    
                                    # Profile Info
                                    <div className="flex-1">
                                        {isEditing and (
                                            <div className="space-y-4">
                                                <div>
                                                    <label className="text-xs font-medium text-foreground mb-1 block">Name</label>
                                                    <input
                                                        type="text"
                                                        value={tempData["name"]}
                                                        onChange={lambda e: any {
                                                            newData = {"name": tempData["name"], "email": tempData["email"], "bio": tempData["bio"]};
                                                            newData["name"] = e.target.value;
                                                            setTempData(newData);
                                                        }}
                                                        className="w-full px-3 py-2 rounded-lg bg-background border border-border text-foreground focus:outline-none focus:ring-2 focus:ring-primary/20"
                                                    />
                                                </div>
                                                <div>
                                                    <label className="text-xs font-medium text-foreground mb-1 block">Email</label>
                                                    <input
                                                        type="email"
                                                        value={tempData["email"]}
                                                        onChange={lambda e: any {
                                                            newData = {"name": tempData["name"], "email": tempData["email"], "bio": tempData["bio"]};
                                                            newData["email"] = e.target.value;
                                                            setTempData(newData);
                                                        }}
                                                        className="w-full px-3 py-2 rounded-lg bg-background border border-border text-foreground focus:outline-none focus:ring-2 focus:ring-primary/20"
                                                    />
                                                </div>
                                                <div>
                                                    <label className="text-xs font-medium text-foreground mb-1 block">Bio</label>
                                                    <textarea
                                                        value={tempData["bio"]}
                                                        onChange={lambda e: any {
                                                            newData = {"name": tempData["name"], "email": tempData["email"], "bio": tempData["bio"]};
                                                            newData["bio"] = e.target.value;
                                                            setTempData(newData);
                                                        }}
                                                        rows={3}
                                                        className="w-full px-3 py-2 rounded-lg bg-background border border-border text-foreground focus:outline-none focus:ring-2 focus:ring-primary/20"
                                                    />
                                                </div>
                                                <div className="flex gap-2">
                                                    <button
                                                        onClick={handleSaveProfile}
                                                        className="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-xl text-sm font-semibold font-display transition-all duration-300 h-10 px-4 bg-primary text-primary-foreground hover:brightness-110 shadow-md hover:shadow-lg"
                                                    >
                                                        <FontAwesomeIcon icon={faSave} className="w-4 h-4 mr-2" />
                                                        Save
                                                    </button>
                                                    <button
                                                        onClick={handleCancelEdit}
                                                        className="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-lg text-xs font-semibold font-display transition-all duration-300 h-10 px-4 border-2 border-border bg-transparent hover:bg-secondary text-foreground hover:border-primary/50"
                                                    >
                                                        Cancel
                                                    </button>
                                                </div>
                                            </div>
                                        ) or (
                                            <div>
                                                <div className="flex items-center justify-between mb-2">
                                                    <h3 className="font-display font-bold text-xl text-foreground">{profileData["name"]}</h3>
                                                    <button
                                                        onClick={handleEditProfile}
                                                        className="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-lg text-xs font-semibold font-display transition-all duration-300 h-9 px-4 border-2 border-border bg-transparent hover:bg-secondary text-foreground hover:border-primary/50"
                                                    >
                                                        <FontAwesomeIcon icon={faEdit} className="w-4 h-4 mr-2" />
                                                        Edit
                                                    </button>
                                                </div>
                                                <p className="text-sm text-muted-foreground mb-4">{profileData["email"]}</p>
                                                <p className="text-sm text-foreground">{profileData["bio"]}</p>
                                                <div className="mt-4 flex items-center gap-4 text-xs text-muted-foreground">
                                                    <div className="flex items-center gap-1">
                                                        <FontAwesomeIcon icon={faMapPin} className="w-3 h-3" />
                                                        <span>{profileData["location"]}</span>
                                                    </div>
                                                    <div className="flex items-center gap-1">
                                                        <FontAwesomeIcon icon={faBriefcase} className="w-3 h-3" />
                                                        <span>{profileData["currentRole"]} at {profileData["company"]}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        )}
                                    </div>
                                </div>
                            </div>
                            
                            # Profile Stats
                            <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-4">
                                <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                    <div className="flex items-center gap-2 mb-2">
                                        <div className="w-8 h-8 rounded-lg bg-primary/20 flex items-center justify-center">
                                            <FontAwesomeIcon icon={faUser} className="w-4 h-4 text-primary" />
                                        </div>
                                        <p className="text-xs text-muted-foreground">Profile Completion</p>
                                    </div>
                                    <p className="text-xl sm:text-2xl font-semibold text-foreground">{String(profileCompletion)}%</p>
                                </div>
                                
                                <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                    <div className="flex items-center gap-2 mb-2">
                                        <div className="w-8 h-8 rounded-lg bg-accent/20 flex items-center justify-center">
                                            <FontAwesomeIcon icon={faWandMagicSparkles} className="w-4 h-4 text-accent" />
                                        </div>
                                        <p className="text-xs text-muted-foreground">Skills Tracked</p>
                                    </div>
                                    <p className="text-xl sm:text-2xl font-semibold text-foreground">24</p>
                                </div>
                                
                                <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                    <div className="flex items-center gap-2 mb-2">
                                        <div className="w-8 h-8 rounded-lg bg-primary/20 flex items-center justify-center">
                                            <FontAwesomeIcon icon={faBook} className="w-4 h-4 text-primary" />
                                        </div>
                                        <p className="text-xs text-muted-foreground">Courses Active</p>
                                    </div>
                                    <p className="text-xl sm:text-2xl font-semibold text-foreground">3</p>
                                </div>
                                
                                <div className="rounded-lg bg-card border border-border/50 p-4 sm:p-5">
                                    <div className="flex items-center gap-2 mb-2">
                                        <div className="w-8 h-8 rounded-lg bg-accent/20 flex items-center justify-center">
                                            <FontAwesomeIcon icon={faAward} className="w-4 h-4 text-accent" />
                                        </div>
                                        <p className="text-xs text-muted-foreground">Certifications</p>
                                    </div>
                                    <p className="text-xl sm:text-2xl font-semibold text-foreground">5</p>
                                </div>
                            </div>
                            
                            # Social Links
                            <div className="rounded-lg bg-card border border-border/50 p-5 sm:p-6">
                                <h3 className="font-display text-base font-semibold text-foreground mb-4">Social Links</h3>
                                <div className="flex flex-wrap gap-3">
                                    {"linkedin" in profileData and profileData["linkedin"] and (
                                        <a href={"https://" + profileData["linkedin"]} target="_blank" rel="noopener noreferrer" className="flex items-center gap-2 px-3 py-2 rounded-lg bg-secondary/30 border border-border/30 hover:border-primary/30 transition-all">
                                            <FontAwesomeIcon icon={faLinkedin} className="w-4 h-4 text-primary" />
                                            <span className="text-sm text-foreground">LinkedIn</span>
                                        </a>
                                    )}
                                    {"github" in profileData and profileData["github"] and (
                                        <a href={"https://" + profileData["github"]} target="_blank" rel="noopener noreferrer" className="flex items-center gap-2 px-3 py-2 rounded-lg bg-secondary/30 border border-border/30 hover:border-primary/30 transition-all">
                                            <FontAwesomeIcon icon={faGithub} className="w-4 h-4 text-primary" />
                                            <span className="text-sm text-foreground">GitHub</span>
                                        </a>
                                    )}
                                    {"twitter" in profileData and profileData["twitter"] and (
                                        <a href={"https://twitter.com/" + profileData["twitter"].replace("@", "")} target="_blank" rel="noopener noreferrer" className="flex items-center gap-2 px-3 py-2 rounded-lg bg-secondary/30 border border-border/30 hover:border-primary/30 transition-all">
                                            <FontAwesomeIcon icon={faXTwitter} className="w-4 h-4 text-primary" />
                                            <span className="text-sm text-foreground">Twitter</span>
                                        </a>
                                    )}
                                </div>
                            </div>
                        </div>
                    )}
                </div>
            </main>
        </div>;
    }
}

# =========================================
# BACKEND: NODE AND EDGE DEFINITIONS
# =========================================
# Nodes and edges are now in nodes.jac (imported at top of file)
