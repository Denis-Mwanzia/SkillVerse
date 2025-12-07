describe('Dashboard E2E', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it('loads dashboard successfully', () => {
    cy.contains('Welcome back').should('be.visible');
    cy.contains('Dashboard').should('be.visible');
  });

  it('displays stats cards', () => {
    cy.get('[data-testid="hero-stats"]').should('exist');
  });

  it('navigates to skills page', () => {
    cy.contains('Skills').click();
    cy.url().should('include', '/skills');
  });
});

