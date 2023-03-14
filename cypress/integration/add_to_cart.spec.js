describe('adding to cart', () => {
  it('should visit the home page successfully', () => {
    cy.visit('http://localhost:3000/')
  });

  it("shows products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("clicks on an add button for a product and adds it to the cart, cart number increases", () => {
    cy.get('.end-0 > .nav-link').contains('My Cart (0)')
    cy.get("button.btn").contains("Add").click({force: true});
    cy.get('.end-0 > .nav-link').contains('My Cart (1)')
  });



})