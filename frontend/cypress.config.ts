import { defineConfig } from 'cypress';

export default defineConfig({
  e2e: {
    baseUrl: 'http://localhost:8080', // Matches vite.config.ts server port
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
    supportFile: 'src/tests/e2e/support/e2e.ts',
    specPattern: 'src/tests/e2e/**/*.cy.{js,jsx,ts,tsx}',
  },
  component: {
    devServer: {
      framework: 'react',
      bundler: 'vite',
    },
    supportFile: 'src/tests/e2e/support/component.ts',
    specPattern: 'src/tests/e2e/**/*.cy.{js,jsx,ts,tsx}',
  },
});

