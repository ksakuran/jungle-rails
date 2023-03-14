describe('product details', () => {
  it('should visit the home page successfully', () => {
    cy.visit('http://localhost:3000/')
  });

  it("shows products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("shows 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("clicks on a product and navigates to that products detail page", () => {
    cy.get(".products article").first().click();
    cy.url().should("include", "/products/2");
    cy.get(".product-detail").should("be.visible");
  });

})