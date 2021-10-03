Feature: movies should appear in alphabetical order, not added order

@omniauth_test_success
Scenario: view movie list after adding 2 movies (imperative and non-DRY)

  Given I am on the RottenPotatoes home page

  When I follow "Log In with Google"
  Then I should see "Logged in successfully."
  
  When I follow "Add new movie"
  Then I should be on the Create New Movie page
  When I fill in "Title" with "Zorro"
  And I select "PG" from "Rating"
  And I press "Save Changes"
  Then I should be on the RottenPotatoes home page
  When I follow "Add new movie"
  Then I should be on the Create New Movie page
  When I fill in "Title" with "Apocalypse Now"
  And I select "R" from "Rating"
  And I press "Save Changes"
  Then I should be on the RottenPotatoes home page
  Then I should see "Apocalypse Now" before "Zorro" on the RottenPotatoes home page sorted by title