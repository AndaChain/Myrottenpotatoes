Feature: movies should appear in alphabetical order, not added order

@omniauth_test_success
Scenario: view movie list after adding movie (declarative and DRY)
  Given I am on the RottenPotatoes home page

  When I follow "Log In with Google"
  Then I should see "Logged in successfully."

  Given I have added "Zorro" with rating "PG-13"
  And   I have added "Apocalypse Now" with rating "R"
  Then  I should see "Apocalypse Now" before "Zorro" on the RottenPotatoes home page sorted by title
