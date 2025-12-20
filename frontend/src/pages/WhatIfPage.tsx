import { WhatIfForm } from '@/components/whatif/WhatIfForm';
import { whatIfApi } from '@/api/whatif';

export default function WhatIfPage() {
  return (
    <div className="space-y-4 sm:space-y-6">
      <div className="px-1">
        <h1 className="text-xl sm:text-2xl font-bold text-foreground">What-If Simulator</h1>
        <p className="text-sm sm:text-base text-muted-foreground">Explore how learning new skills impacts your career</p>
      </div>
      
      <div className="rounded-lg border border-border bg-card p-3 sm:p-4 md:p-6">
        <WhatIfForm onSimulate={(skills, timeframe) => whatIfApi.simulate({ userId: 'user_1', scenario: { skillsToLearn: skills, timeframe } })} />
      </div>
    </div>
  );
}
