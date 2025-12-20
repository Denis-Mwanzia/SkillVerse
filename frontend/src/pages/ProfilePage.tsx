import { useState } from 'react';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { ProfileHeader, ProfileForm, PasswordForm, ProfileStats, PreferencesForm } from '@/components/profile';
import { useAuth } from '@/hooks/useAuth';
import { useAuthStore } from '@/store/uiStore';
import { authApi } from '@/api/auth';
import { motion } from 'framer-motion';
import { useReducedMotion } from '@/utils/motion';
import { User, Settings, Key, BarChart3 } from 'lucide-react';
import { Skeleton } from '@/components/ui/skeleton';

export default function ProfilePage() {
  const { user, isLoading } = useAuth();
  const { setUser } = useAuthStore();
  const prefersReducedMotion = useReducedMotion();
  const [isEditing, setIsEditing] = useState(false);

  if (isLoading) {
    return (
      <div className="max-w-5xl mx-auto space-y-6">
        <Skeleton className="h-64 w-full rounded-xl" />
        <Skeleton className="h-96 w-full rounded-xl" />
      </div>
    );
  }

  if (!user) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <p className="text-muted-foreground">Please log in to view your profile.</p>
      </div>
    );
  }

  const handleProfileUpdate = async (data: {
    name: string;
    email: string;
    bio?: string;
    location?: string;
    website?: string;
    linkedin?: string;
    github?: string;
  }) => {
    const updatedUser = await authApi.updateProfile(data);
    setUser(updatedUser);
    setIsEditing(false);
  };

  const handlePasswordUpdate = async (data: { currentPassword: string; newPassword: string }) => {
    await authApi.updatePassword(data);
  };

  const handleAvatarChange = async (file: File) => {
    const { avatarUrl } = await authApi.uploadAvatar(file);
    const updatedUser = await authApi.getProfile();
    setUser({ ...updatedUser, avatar: avatarUrl });
  };

  return (
    <motion.div
      initial={prefersReducedMotion ? { opacity: 1 } : { opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: prefersReducedMotion ? 0 : 0.4 }}
      className="w-full max-w-5xl mx-auto space-y-4 sm:space-y-6 px-1"
    >
      <ProfileHeader user={user} onAvatarChange={handleAvatarChange} isEditing={isEditing} />

      <Tabs defaultValue="profile" className="space-y-4 sm:space-y-6">
        <TabsList className="grid w-full grid-cols-4 lg:w-auto lg:inline-flex">
          <TabsTrigger value="profile" className="flex items-center gap-1.5 sm:gap-2 text-xs sm:text-sm">
            <User className="h-3 w-3 sm:h-4 sm:w-4" />
            <span className="hidden xs:inline">Profile</span>
          </TabsTrigger>
          <TabsTrigger value="security" className="flex items-center gap-1.5 sm:gap-2 text-xs sm:text-sm">
            <Key className="h-3 w-3 sm:h-4 sm:w-4" />
            <span className="hidden xs:inline">Security</span>
          </TabsTrigger>
          <TabsTrigger value="preferences" className="flex items-center gap-1.5 sm:gap-2 text-xs sm:text-sm">
            <Settings className="h-3 w-3 sm:h-4 sm:w-4" />
            <span className="hidden xs:inline">Settings</span>
          </TabsTrigger>
          <TabsTrigger value="stats" className="flex items-center gap-1.5 sm:gap-2 text-xs sm:text-sm">
            <BarChart3 className="h-3 w-3 sm:h-4 sm:w-4" />
            <span className="hidden xs:inline">Stats</span>
          </TabsTrigger>
        </TabsList>

        <TabsContent value="profile" className="space-y-4 sm:space-y-6">
          <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 sm:gap-4">
            <div>
              <h2 className="text-xl sm:text-2xl font-bold text-foreground">Profile Information</h2>
              <p className="text-sm sm:text-base text-muted-foreground">Manage your personal information and public profile</p>
            </div>
            <button
              onClick={() => setIsEditing(!isEditing)}
              className="text-sm text-primary hover:underline self-start sm:self-auto"
            >
              {isEditing ? 'Cancel Editing' : 'Edit Profile'}
            </button>
          </div>
          <ProfileForm user={user} onSubmit={handleProfileUpdate} />
        </TabsContent>

        <TabsContent value="security" className="space-y-4 sm:space-y-6">
          <div>
            <h2 className="text-xl sm:text-2xl font-bold text-foreground">Security Settings</h2>
            <p className="text-sm sm:text-base text-muted-foreground">Manage your password and security preferences</p>
          </div>
          <PasswordForm onSubmit={handlePasswordUpdate} />
        </TabsContent>

        <TabsContent value="preferences" className="space-y-4 sm:space-y-6">
          <div>
            <h2 className="text-xl sm:text-2xl font-bold text-foreground">Preferences</h2>
            <p className="text-sm sm:text-base text-muted-foreground">Customize your SkillVerse experience</p>
          </div>
          <PreferencesForm />
        </TabsContent>

        <TabsContent value="stats" className="space-y-4 sm:space-y-6">
          <div>
            <h2 className="text-xl sm:text-2xl font-bold text-foreground">Your Statistics</h2>
            <p className="text-sm sm:text-base text-muted-foreground">View your learning progress and achievements</p>
          </div>
          <ProfileStats />
        </TabsContent>
      </Tabs>
    </motion.div>
  );
}
