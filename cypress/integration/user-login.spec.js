describe("sign up and log in a user", () => {
  it("should visit the home page successfully", () => {
    cy.visit("http://localhost:3000/");
  });

  it("shows products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("clicks on sign up in the nav bar", () => {
    cy.get('[href="/signup"]').click();
    cy.get(".page-header > h1").contains("New User Registration");
  });

  it("fills out the form and successfully registers and logs user in", () => {
    // cy.get('[href="/signup"]').click()
    // cy.get('.page-header > h1').contains("New User Registration")
    cy.get("#user_first_name").type("First");
    cy.get("#user_last_name").type("Last");
    cy.get("#user_email").type("first@last.com");
    cy.get("#user_password").type("password123");
    cy.get("#user_password_confirmation").type("password123");
    cy.get(".btn").click({ force: true });

    cy.get('.text-user').contains("Signed in as First");
  });

  it("logs the user out and you are redirected to the login page", () => {
    cy.get('.text-user > .nav-link').click({ force: true });
    cy.get('.page-header > h1').contains("Login")
  });

  // it("logs the registered user in again", () => {
  //   cy.get("#email").type("first@last.com");
  //   cy.get("#password").type("password123");
  //   cy.get(".btn").click({ force: true });
  //   cy.get('.text-user').contains("Signed in as First");
  // });

});
