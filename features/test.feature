Feature: User can manually add movie

Scenario: Add a movie
  Given I am on the RottenPotatoes home page
  When I follow "Log In with Google"
  Then I should be on "/auth/google_oauth2"
