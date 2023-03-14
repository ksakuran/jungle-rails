
describe('home page', () => {
  it('should visit the home page successfully', () => {
    cy.visit('http://localhost:3000/')
  });

  it("shows products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("shows 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });


})