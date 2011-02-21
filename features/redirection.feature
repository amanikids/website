Feature: Redirection
  As an FOA member hosting a fundraiser on another website
  I would like to have a short url at amanikids.org redirect to that other website
  So that I can hand out something that will be far easier for people to remember and type.

  Scenario: Diane's bike ride
    Given a home page has been created for the website
    When I go to "/ride"
    Then I should be at "www.events.org"
    And I should be on "/sponsorshipteams.aspx"
    And I should have the following query string:
      | event | 31734 |
      | team  | 116   |
