# Skillverse Career Navigation Platform
cl import from "react" {useState}
cl import from "react-router-dom" {BrowserRouter, Routes, Route, Link, useNavigate, HashRouter}
cl import from "@fortawesome/react-fontawesome" {FontAwesomeIcon}
cl import from "./client_runtime.js" {jacSpawn, __setLocalStorage}
cl import from "@fortawesome/free-solid-svg-icons" {faFileText, faBullseye, faChartLine, faMap, faArrowRight, faMagic, faInfoCircle, faEnvelope, faHeart, faLightbulb, faBolt, faTrophy, faCode, faClock, faCrown, faAward, faRocket, faUser, faLock, faEye, faEyeSlash, faArrowLeft, faSun, faMoon, faBars, faTimes, faArrowUp, faBook, faGlobe, faWandMagicSparkles, faBell, faCog, faSignOutAlt}
cl import from "@fortawesome/free-brands-svg-icons" {faXTwitter, faLinkedin, faGithub, faGoogle}

# Main App Component with Routing
cl {
    def app() -> any {
        return <HashRouter>
            <Routes>
                <Route path="/" element={<IndexPage />} />
                <Route path="/about" element={<AboutPage />} />
                <Route path="/contact" element={<ContactPage />} />
                <Route path="/auth" element={<AuthPage />} />
                <Route path="/dashboard" element={<DashboardPage />} />
            </Routes>
        </HashRouter>;
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
        def toggleTheme() -> any {
            isDark = document.documentElement.classList.contains("dark");
            if (isDark) {
                document.documentElement.classList.remove("dark");
                localStorage.setItem("theme", "light");
            } else {
                document.documentElement.classList.add("dark");
                localStorage.setItem("theme", "dark");
            }
            return None;
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
        def toggleMenu() -> any {
            setMenuOpen(not menuOpen);
            return None;
        }
        
        # Close menu when link is clicked
        def closeMenu() -> any {
            setMenuOpen(false);
            return None;
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
        let features = [
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
                        let index = features.indexOf(feature);
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
                let steps = [
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
                                let index = steps.indexOf(step);
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
    
    # Auth utility functions (all in Jac)
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
        
        # Handle login form submission
        def handleLoginSubmit(e: any) {
            e.preventDefault();
            isLoading[1](true);
            errorMessage[1]("");
            successMessage[1]("");
            
            # Call user_login walker
            result = jacSpawn("user_login", "", {
                "username": loginEmail[0],
                "password": loginPassword[0]
            });
            
            # Handle promise result
            def handleResult(result: any) {
                if result and result.report and len(result.report) > 0 {
                    report_data = result.report[0];
                    if report_data.success and report_data.token {
                        __setLocalStorage("jac_token", report_data.token);
                        successMessage[1]("Login successful! Redirecting...");
                        def navigateAfterDelay() {
                            navigate("/dashboard");
                        }
                        setTimeout(navigateAfterDelay, 1000);
                    } else {
                        errorMsg = report_data.error or "Invalid email or password. Please try again.";
                        errorMessage[1](errorMsg);
                        isLoading[1](false);
                    }
                } else {
                    errorMessage[1]("Login failed. Please try again.");
                    isLoading[1](false);
                }
            }
            
            def handleError(error: any) {
                errorMessage[1]("Login failed. Please try again.");
                isLoading[1](false);
            }
            
            result.then(handleResult).catch(handleError);
        }
        
        # Handle signup form submission
        def handleSignupSubmit(e: any) {
            e.preventDefault();
            isLoading[1](true);
            errorMessage[1]("");
            successMessage[1]("");
            
            # Call user_create walker
            result = jacSpawn("user_create", "", {
                "username": signupEmail[0],
                "password": signupPassword[0],
                "email": signupEmail[0],
                "name": signupName[0] or ""
            });
            
            # Handle promise result
            def handleResult(result: any) {
                globalThis.console.log("Signup result:", result);
                if result and result.report and len(result.report) > 0 {
                    report_data = result.report[0];
                    if report_data.success and report_data.token {
                        __setLocalStorage("jac_token", report_data.token);
                        successMessage[1]("Account created successfully! Redirecting...");
                        def navigateAfterDelay() {
                            navigate("/dashboard");
                        }
                        setTimeout(navigateAfterDelay, 1000);
                    } else {
                        errorMsg = report_data.error or "Signup failed. Please try again.";
                        errorMessage[1](errorMsg);
                        isLoading[1](false);
                    }
                } else {
                    errorMsg = "Unexpected response format. Please check server connection.";
                    if result {
                        errorMsg = "Signup failed: " + str(result);
                    }
                    errorMessage[1](errorMsg);
                    isLoading[1](false);
                }
            }
            
            def handleError(error: any) {
                errorMsg = "Signup failed. Please try again.";
                if error and error.message {
                    errorMsg = error.message;
                } else {
                    if error {
                        errorMsg = "Error: " + str(error);
                    }
                }
                errorMessage[1](errorMsg);
                isLoading[1](false);
                # Log error for debugging
                globalThis.console.error("Signup error:", error);
            }
            
            result.then(handleResult).catch(handleError);
        }
        
        # Form input handlers
        def handleLoginEmailChange(e: any) {
            loginEmail[1](e.target.value);
        }
        
        def handleLoginPasswordChange(e: any) {
            loginPassword[1](e.target.value);
        }
        
        def handleSignupNameChange(e: any) {
            signupName[1](e.target.value);
        }
        
        def handleSignupEmailChange(e: any) {
            signupEmail[1](e.target.value);
        }
        
        def handleSignupPasswordChange(e: any) {
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
        
        # Toggle mobile sidebar
        def toggleSidebar() -> any {
            setSidebarOpen(not sidebarOpen);
            return None;
        }
        
        # Close mobile sidebar
        def closeSidebar() -> any {
            setSidebarOpen(false);
            return None;
        }
        
        # Tab change handlers
        def handleOverviewTab() -> any {
            setActiveTab("overview");
            closeSidebar();
            return None;
        }
        def handleResumeTab() -> any {
            setActiveTab("resume");
            closeSidebar();
            return None;
        }
        def handleTargetsTab() -> any {
            setActiveTab("targets");
            closeSidebar();
            return None;
        }
        def handleGapAnalysisTab() -> any {
            setActiveTab("gap-analysis");
            closeSidebar();
            return None;
        }
        def handleRoadmapTab() -> any {
            setActiveTab("roadmap");
            closeSidebar();
            return None;
        }
        def handleMarketTab() -> any {
            setActiveTab("market");
            closeSidebar();
            return None;
        }
        def handleProgressTab() -> any {
            setActiveTab("progress");
            closeSidebar();
            return None;
        }
        def handleProfileTab() -> any {
            setActiveTab("profile");
            closeSidebar();
            return None;
        }
        
        # Desktop tab handlers (no sidebar close)
        def handleOverviewTabDesktop() -> any {
            setActiveTab("overview");
            return None;
        }
        def handleResumeTabDesktop() -> any {
            setActiveTab("resume");
            return None;
        }
        def handleTargetsTabDesktop() -> any {
            setActiveTab("targets");
            return None;
        }
        def handleGapAnalysisTabDesktop() -> any {
            setActiveTab("gap-analysis");
            return None;
        }
        def handleRoadmapTabDesktop() -> any {
            setActiveTab("roadmap");
            return None;
        }
        def handleMarketTabDesktop() -> any {
            setActiveTab("market");
            return None;
        }
        def handleProgressTabDesktop() -> any {
            setActiveTab("progress");
            return None;
        }
        def handleProfileTabDesktop() -> any {
            setActiveTab("profile");
            return None;
        }
        
        # Handle logout
        def handleLogout() {
            token = globalThis.localStorage.getItem("jac_token");
            if token {
                # Try to call logout walker (ignore if it doesn't exist)
                result = jacSpawn("user_logout", "", {"token": token});
            }
            globalThis.localStorage.removeItem("jac_token");
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
        overviewClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm ";
        if activeTab == "overview" {
            overviewClassMobile = overviewClassMobile + "bg-primary/10 text-primary font-medium";
        } else {
            overviewClassMobile = overviewClassMobile + "text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        }
        
        resumeClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm ";
        if activeTab == "resume" {
            resumeClassMobile = resumeClassMobile + "bg-primary/10 text-primary font-medium";
        } else {
            resumeClassMobile = resumeClassMobile + "text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        }
        
        targetsClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm ";
        if activeTab == "targets" {
            targetsClassMobile = targetsClassMobile + "bg-primary/10 text-primary font-medium";
        } else {
            targetsClassMobile = targetsClassMobile + "text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        }
        
        gapClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm ";
        if activeTab == "gap-analysis" {
            gapClassMobile = gapClassMobile + "bg-primary/10 text-primary font-medium";
        } else {
            gapClassMobile = gapClassMobile + "text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        }
        
        roadmapClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm ";
        if activeTab == "roadmap" {
            roadmapClassMobile = roadmapClassMobile + "bg-primary/10 text-primary font-medium";
        } else {
            roadmapClassMobile = roadmapClassMobile + "text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        }
        
        marketClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm ";
        if activeTab == "market" {
            marketClassMobile = marketClassMobile + "bg-primary/10 text-primary font-medium";
        } else {
            marketClassMobile = marketClassMobile + "text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        }
        
        progressClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm ";
        if activeTab == "progress" {
            progressClassMobile = progressClassMobile + "bg-primary/10 text-primary font-medium";
        } else {
            progressClassMobile = progressClassMobile + "text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        }
        
        profileClassMobile = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all text-sm ";
        if activeTab == "profile" {
            profileClassMobile = profileClassMobile + "bg-primary/10 text-primary font-medium";
        } else {
            profileClassMobile = profileClassMobile + "text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        }
        
        # Compute className for desktop nav buttons
        baseClassDesktop = "w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all relative text-sm ";
        activeClassDesktop = "bg-primary/10 text-primary font-medium";
        inactiveClassDesktop = "text-muted-foreground hover:bg-secondary/50 hover:text-foreground";
        
        if activeTab == "overview" {
            overviewClassDesktop = baseClassDesktop + activeClassDesktop;
        } else {
            overviewClassDesktop = baseClassDesktop + inactiveClassDesktop;
        }
        if activeTab == "resume" {
            resumeClassDesktop = baseClassDesktop + activeClassDesktop;
        } else {
            resumeClassDesktop = baseClassDesktop + inactiveClassDesktop;
        }
        if activeTab == "targets" {
            targetsClassDesktop = baseClassDesktop + activeClassDesktop;
        } else {
            targetsClassDesktop = baseClassDesktop + inactiveClassDesktop;
        }
        if activeTab == "gap-analysis" {
            gapClassDesktop = baseClassDesktop + activeClassDesktop;
        } else {
            gapClassDesktop = baseClassDesktop + inactiveClassDesktop;
        }
        if activeTab == "roadmap" {
            roadmapClassDesktop = baseClassDesktop + activeClassDesktop;
        } else {
            roadmapClassDesktop = baseClassDesktop + inactiveClassDesktop;
        }
        if activeTab == "market" {
            marketClassDesktop = baseClassDesktop + activeClassDesktop;
        } else {
            marketClassDesktop = baseClassDesktop + inactiveClassDesktop;
        }
        if activeTab == "progress" {
            progressClassDesktop = baseClassDesktop + activeClassDesktop;
        } else {
            progressClassDesktop = baseClassDesktop + inactiveClassDesktop;
        }
        if activeTab == "profile" {
            profileClassDesktop = baseClassDesktop + activeClassDesktop;
        } else {
            profileClassDesktop = baseClassDesktop + inactiveClassDesktop;
        }
        
        # Compute icon classes for desktop
        if activeTab == "overview" {
            iconClassOverview = "w-4 h-4 relative z-10 text-primary";
        } else {
            iconClassOverview = "w-4 h-4 relative z-10";
        }
        if activeTab == "resume" {
            iconClassResume = "w-4 h-4 relative z-10 text-primary";
        } else {
            iconClassResume = "w-4 h-4 relative z-10";
        }
        if activeTab == "targets" {
            iconClassTargets = "w-4 h-4 relative z-10 text-primary";
        } else {
            iconClassTargets = "w-4 h-4 relative z-10";
        }
        if activeTab == "gap-analysis" {
            iconClassGap = "w-4 h-4 relative z-10 text-primary";
        } else {
            iconClassGap = "w-4 h-4 relative z-10";
        }
        if activeTab == "roadmap" {
            iconClassRoadmap = "w-4 h-4 relative z-10 text-primary";
        } else {
            iconClassRoadmap = "w-4 h-4 relative z-10";
        }
        if activeTab == "market" {
            iconClassMarket = "w-4 h-4 relative z-10 text-primary";
        } else {
            iconClassMarket = "w-4 h-4 relative z-10";
        }
        if activeTab == "progress" {
            iconClassProgress = "w-4 h-4 relative z-10 text-primary";
        } else {
            iconClassProgress = "w-4 h-4 relative z-10";
        }
        if activeTab == "profile" {
            iconClassProfile = "w-4 h-4 relative z-10 text-primary";
        } else {
            iconClassProfile = "w-4 h-4 relative z-10";
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
        
        # Compute mobile menu icon
        mobileMenuIcon = faBars;
        if sidebarOpen {
            mobileMenuIcon = faTimes;
        }
        
        # Mobile sidebar content
        mobileSidebar = None;
        if sidebarOpen {
            mobileSidebar = <div>
                <div 
                    className="fixed inset-0 bg-background/80 backdrop-blur-sm z-40 lg:hidden"
                    onClick={closeSidebar}
                />
                <aside className="fixed left-0 top-0 h-full w-70 bg-background/95 backdrop-blur-xl border-r border-border/50 z-50 lg:hidden">
                    <div className="p-5 h-full flex flex-col">
                        <div className="flex items-center justify-between mb-8 shrink-0">
                            <Link to="/" className="flex items-center">
                                <span className="text-2xl font-bold text-primary">Skillverse</span>
                            </Link>
                            <button
                                onClick={closeSidebar}
                                className="p-2 rounded-lg hover:bg-secondary/50 transition-colors"
                            >
                                <FontAwesomeIcon icon={faTimes} className="w-5 h-5" />
                            </button>
                        </div>
                        
                        <nav className="space-y-1 flex-1 overflow-y-auto">
                            # Overview tab
                            <button onClick={handleOverviewTab} className={overviewClassMobile}>
                                <FontAwesomeIcon icon={faChartLine} className="w-4 h-4" />
                                <span>Overview</span>
                            </button>
                            # Resume tab
                            <button onClick={handleResumeTab} className={resumeClassMobile}>
                                <FontAwesomeIcon icon={faFileText} className="w-4 h-4" />
                                <span>Resume</span>
                            </button>
                            # Career Targets tab
                            <button onClick={handleTargetsTab} className={targetsClassMobile}>
                                <FontAwesomeIcon icon={faBullseye} className="w-4 h-4" />
                                <span>Career Targets</span>
                            </button>
                            # Skill Gap tab
                            <button onClick={handleGapAnalysisTab} className={gapClassMobile}>
                                <FontAwesomeIcon icon={faArrowUp} className="w-4 h-4" />
                                <span>Skill Gap</span>
                            </button>
                            # Learning Roadmap tab
                            <button onClick={handleRoadmapTab} className={roadmapClassMobile}>
                                <FontAwesomeIcon icon={faBook} className="w-4 h-4" />
                                <span>Learning Roadmap</span>
                            </button>
                            # Market Intelligence tab
                            <button onClick={handleMarketTab} className={marketClassMobile}>
                                <FontAwesomeIcon icon={faGlobe} className="w-4 h-4" />
                                <span>Market Intelligence</span>
                            </button>
                            # Progress tab
                            <button onClick={handleProgressTab} className={progressClassMobile}>
                                <FontAwesomeIcon icon={faWandMagicSparkles} className="w-4 h-4" />
                                <span>Progress</span>
                            </button>
                            # Profile tab
                            <button onClick={handleProfileTab} className={profileClassMobile}>
                                <FontAwesomeIcon icon={faUser} className="w-4 h-4" />
                                <span>Profile</span>
                            </button>
                        </nav>
                        
                        <div className="border-t border-border/50 pt-4 mt-auto shrink-0">
                            <button
                                onClick={handleProfileTab}
                                className="flex items-center gap-3 mb-3 w-full p-2 rounded-lg hover:bg-secondary/50 transition-colors"
                            >
                                <div className="w-9 h-9 rounded-full bg-gradient-to-br from-primary to-primary/60 flex items-center justify-center overflow-hidden flex-shrink-0">
                                    <span className="font-semibold text-primary-foreground text-xs">{userInfo["initials"]}</span>
                                </div>
                                <div className="flex-1 min-w-0 text-left">
                                    <p className="font-medium text-foreground text-sm truncate">{userInfo["name"]}</p>
                                    <p className="text-muted-foreground text-xs truncate">{userInfo["email"]}</p>
                                </div>
                            </button>
                            <div className="flex gap-1.5">
                                <button 
                                    onClick={handleProfileTab}
                                    className="flex-1 h-8 w-8 rounded-lg hover:bg-secondary/50 transition-colors flex items-center justify-center"
                                    title="Profile Settings"
                                >
                                    <FontAwesomeIcon icon={faCog} className="w-4 h-4" />
                                </button>
                                <ThemeToggle />
                                <button 
                                    onClick={handleLogout}
                                    className="h-8 w-8 rounded-lg hover:bg-secondary/50 transition-colors flex items-center justify-center"
                                    title="Logout"
                                >
                                    <FontAwesomeIcon icon={faSignOutAlt} className="w-4 h-4" />
                                </button>
                            </div>
                        </div>
                    </div>
                </aside>
            </div>;
        }
        
        return <div className="min-h-screen bg-background">
            {mobileSidebar}
            
            # Desktop Sidebar
            <aside className="fixed left-0 top-0 h-full w-64 bg-background/95 backdrop-blur-xl border-r border-border/50 z-50 hidden lg:block">
                <div className="p-5 h-full flex flex-col">
                    <Link to="/" className="flex items-center mb-8 group shrink-0">
                        <span className="text-2xl font-bold text-primary group-hover:opacity-90 transition-opacity">Skillverse</span>
                    </Link>
                    
                    <nav className="space-y-1 flex-1 overflow-y-auto">
                        # Overview tab
                        # Overview tab
                        <button onClick={handleOverviewTabDesktop} className={overviewClassDesktop}>
                            {overviewIndicator}
                            <FontAwesomeIcon icon={faChartLine} className={iconClassOverview} />
                            <span className="relative z-10">Overview</span>
                        </button>
                        # Resume tab
                        <button onClick={handleResumeTabDesktop} className={resumeClassDesktop}>
                            {resumeIndicator}
                            <FontAwesomeIcon icon={faFileText} className={iconClassResume} />
                            <span className="relative z-10">Resume</span>
                        </button>
                        # Career Targets tab
                        <button onClick={handleTargetsTabDesktop} className={targetsClassDesktop}>
                            {targetsIndicator}
                            <FontAwesomeIcon icon={faBullseye} className={iconClassTargets} />
                            <span className="relative z-10">Career Targets</span>
                        </button>
                        # Skill Gap tab
                        <button onClick={handleGapAnalysisTabDesktop} className={gapClassDesktop}>
                            {gapIndicator}
                            <FontAwesomeIcon icon={faArrowUp} className={iconClassGap} />
                            <span className="relative z-10">Skill Gap</span>
                        </button>
                        # Learning Roadmap tab
                        <button onClick={handleRoadmapTabDesktop} className={roadmapClassDesktop}>
                            {roadmapIndicator}
                            <FontAwesomeIcon icon={faBook} className={iconClassRoadmap} />
                            <span className="relative z-10">Learning Roadmap</span>
                        </button>
                        # Market Intelligence tab
                        <button onClick={handleMarketTabDesktop} className={marketClassDesktop}>
                            {marketIndicator}
                            <FontAwesomeIcon icon={faGlobe} className={iconClassMarket} />
                            <span className="relative z-10">Market Intelligence</span>
                        </button>
                        # Progress tab
                        <button onClick={handleProgressTabDesktop} className={progressClassDesktop}>
                            {progressIndicator}
                            <FontAwesomeIcon icon={faWandMagicSparkles} className={iconClassProgress} />
                            <span className="relative z-10">Progress</span>
                        </button>
                        # Profile tab
                        <button onClick={handleProfileTabDesktop} className={profileClassDesktop}>
                            {profileIndicator}
                            <FontAwesomeIcon icon={faUser} className={iconClassProfile} />
                            <span className="relative z-10">Profile</span>
                        </button>
                    </nav>
                    
                    <div className="border-t border-border/50 pt-4 mt-auto shrink-0">
                        <button
                            onClick={handleProfileTab}
                            className="flex items-center gap-3 mb-3 w-full p-2 rounded-lg hover:bg-secondary/50 transition-colors"
                        >
                            <div className="w-9 h-9 rounded-full bg-gradient-to-br from-primary to-primary/60 flex items-center justify-center overflow-hidden flex-shrink-0">
                                <span className="font-semibold text-primary-foreground text-xs">{userInfo["initials"]}</span>
                            </div>
                            <div className="flex-1 min-w-0 text-left">
                                <p className="font-medium text-foreground text-sm truncate">{userInfo["name"]}</p>
                                <p className="text-muted-foreground text-xs truncate">{userInfo["email"]}</p>
                            </div>
                        </button>
                        <div className="flex gap-1.5">
                            <button 
                                onClick={handleProfileTab}
                                className="flex-1 h-8 w-8 rounded-lg hover:bg-secondary/50 transition-colors flex items-center justify-center"
                                title="Profile Settings"
                            >
                                <FontAwesomeIcon icon={faCog} className="w-4 h-4" />
                            </button>
                            <ThemeToggle />
                            <button 
                                onClick={handleLogout}
                                className="h-8 w-8 rounded-lg hover:bg-secondary/50 transition-colors flex items-center justify-center"
                                title="Logout"
                            >
                                <FontAwesomeIcon icon={faSignOutAlt} className="w-4 h-4" />
                            </button>
                        </div>
                    </div>
                </div>
            </aside>
            
            # Main Content
            <main className="lg:ml-64 min-h-screen bg-background">
                # Header
                <header className="sticky top-0 z-40 bg-background/95 backdrop-blur-xl border-b border-border/50">
                    <div className="flex items-center justify-between px-5 sm:px-6 lg:px-8 py-3.5">
                        <div className="flex items-center gap-3">
                            <button
                                onClick={toggleSidebar}
                                className="lg:hidden p-2 rounded-lg hover:bg-secondary/50 transition-colors"
                            >
                                <FontAwesomeIcon icon={mobileMenuIcon} className="w-5 h-5" />
                            </button>
                            <h1 className="text-xl font-semibold text-foreground">{tabLabel}</h1>
                        </div>
                        <div className="flex items-center gap-2">
                            <button className="p-2 rounded-lg hover:bg-secondary/50 transition-colors relative">
                                <FontAwesomeIcon icon={faBell} className="w-5 h-5 text-muted-foreground" />
                                <span className="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full"></span>
                            </button>
                        </div>
                    </div>
                </header>
                
                # Content Area - Tab content will be added in Phase 2+
                <div className="p-5 sm:p-6 lg:p-8">
                    <div className="text-center py-20">
                        <p className="text-muted-foreground text-lg">Select a tab to view content</p>
                        <p className="text-muted-foreground text-sm mt-2">Active tab: {activeTab}</p>
                    </div>
                </div>
            </main>
        </div>;
    }
}

# =========================================
# BACKEND: NODE AND EDGE DEFINITIONS
# =========================================
# Nodes and edges are now in nodes.jac (imported at top of file)
