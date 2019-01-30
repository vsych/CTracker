Feature: Manage countries
  In order to manage his travel itinerary
  Mr. Smart
  wants to manage the countries he has visited.

  Scenario: List Counties
    Given list of countries exists
    Then I should see table with countries

  @javascript
  Scenario: Visit Country
    Given list of countries exists
    When I check country as visited
    Then status of country should change to "Visited"

  @javascript
  Scenario: Undo visit Country
    Given list of countries exists
    When I check country as not visited
    Then status of country should change to "Not Visited"

  Scenario: Navigating to country details page
    When I open country detials page
    Then I should see list of currencies available in this country
