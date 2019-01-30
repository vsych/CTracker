Feature: Manage currencies
  In order to manage currencies separatly
  Mr. Smart
  watns to manage currencies he has collected.

  Scenario: List Currencies
    Given list of currencies exists
    Then I should see table with them

  Scenario: Navigating to currency detail page
    When I want to look on currency closed
    Then I open currency detail page

  @javascript
  Scenario: Collect Currency
    Given list of currencies exists
    When I mark one the currencies as collected
    Then its status changed to "Collected"

  @javascript
  Scenario: Undo collect Currency
    Given list of currencies exists
    When I mark one the currencies as not collected
    Then its status changed to "Not Collected"
