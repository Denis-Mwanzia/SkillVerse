import { Link, useLocation } from 'react-router-dom';
import { 
  LayoutDashboard, 
  Network, 
  FileText, 
  Target, 
  BookOpen, 
  TrendingUp, 
  Brain,
  Lightbulb,
  User
} from 'lucide-react';
import {
  Sidebar,
  SidebarContent,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarHeader,
  SidebarFooter,
} from '@/components/ui/sidebar';
import { SkillVerseLogo } from '@/components/ui/skillverse-logo';
import { cn } from '@/lib/utils';

const mainNavItems = [
  { title: 'Dashboard', url: '/', icon: LayoutDashboard },
  { title: 'Skill Graph', url: '/skills', icon: Network },
  { title: 'Resume Analyzer', url: '/resume', icon: FileText },
];

const careerNavItems = [
  { title: 'Gap Analysis', url: '/gap-analysis', icon: Target },
  { title: 'Learning Path', url: '/learning', icon: BookOpen },
  { title: 'Market Trends', url: '/trends', icon: TrendingUp },
];

const toolsNavItems = [
  { title: 'Skill Quizzes', url: '/quizzes', icon: Brain },
  { title: 'What-If Simulator', url: '/what-if', icon: Lightbulb },
];

export function AppSidebar() {
  const location = useLocation();

  const NavItem = ({ item }: { item: typeof mainNavItems[0] }) => {
    const isActive = location.pathname === item.url;
    return (
      <SidebarMenuItem>
        <SidebarMenuButton asChild>
          <Link
            to={item.url}
            className={cn(
              'flex items-center gap-3 px-3 py-2 rounded-md transition-colors',
              isActive
                ? 'bg-primary text-primary-foreground'
                : 'text-muted-foreground hover:bg-accent hover:text-accent-foreground'
            )}
          >
            <item.icon className="h-4 w-4" />
            <span className="font-medium">{item.title}</span>
          </Link>
        </SidebarMenuButton>
      </SidebarMenuItem>
    );
  };

  return (
    <Sidebar className="border-r border-border">
      <SidebarHeader className="p-4">
        <SkillVerseLogo variant="sidebar" size="md" />
      </SidebarHeader>
      
      <SidebarContent className="px-2">
        <SidebarGroup>
          <SidebarGroupLabel className="text-xs font-semibold text-muted-foreground uppercase tracking-wider px-3 mb-2">
            Overview
          </SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {mainNavItems.map((item) => (
                <NavItem key={item.url} item={item} />
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>

        <SidebarGroup className="mt-4">
          <SidebarGroupLabel className="text-xs font-semibold text-muted-foreground uppercase tracking-wider px-3 mb-2">
            Career Growth
          </SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {careerNavItems.map((item) => (
                <NavItem key={item.url} item={item} />
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>

        <SidebarGroup className="mt-4">
          <SidebarGroupLabel className="text-xs font-semibold text-muted-foreground uppercase tracking-wider px-3 mb-2">
            Tools
          </SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {toolsNavItems.map((item) => (
                <NavItem key={item.url} item={item} />
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>
      </SidebarContent>

      <SidebarFooter className="p-4 border-t border-border">
        <Link
          to="/profile"
          className={cn(
            'flex items-center gap-3 px-3 py-2 rounded-md transition-colors',
            location.pathname === '/profile'
              ? 'bg-primary text-primary-foreground'
              : 'text-muted-foreground hover:bg-accent hover:text-accent-foreground'
          )}
        >
          <User className="h-4 w-4" />
          <span className="font-medium">Profile</span>
        </Link>
      </SidebarFooter>
    </Sidebar>
  );
}
