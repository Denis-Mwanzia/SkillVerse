import { ReactNode } from 'react';
import { SidebarProvider } from '@/components/ui/sidebar';
import { SkipLink } from '@/components/ui/skip-link';
import { AppSidebar } from './AppSidebar';
import { Navbar } from './Navbar';
import { Footer } from './Footer';

interface MainLayoutProps {
  children: ReactNode;
}

export function MainLayout({ children }: MainLayoutProps) {
  return (
    <SidebarProvider>
      <SkipLink />
      <div className="min-h-screen flex w-full bg-background">
        <AppSidebar />
        <div className="flex-1 flex flex-col min-h-screen w-full min-w-0">
          <Navbar />
          <main 
            id="main-content" 
            className="flex-1 p-3 sm:p-4 md:p-6 overflow-auto w-full"
            tabIndex={-1}
            role="main"
          >
            <div className="w-full max-w-full mx-auto">
              {children}
            </div>
          </main>
          <Footer />
        </div>
      </div>
    </SidebarProvider>
  );
}
