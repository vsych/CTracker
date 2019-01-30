Feature: Manage users
  In order to make application more secured
  Every user should be chalanged with logins page
  And have opportunity to edit only their data

  Scenario: Visiting as no regular user
    Given I am not logged in
    Then I open home page
    When I should see login form
    And Page should not contain links to "Currencies" and "Countries"

  Scenario: Visiting as registered user
    Given I am logged in
    Then I open home page
    When I should see "Currencies" and "Countries" links

  Scenario: Fill not valid credentials on login page
    Then I fill invalid credentials
    When I should see error message
