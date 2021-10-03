
Feature: User can manually add review

@omniauth_test_success
Scenario: Add a review
  Given I am on the RottenPotatoes home page
  When I follow "Log In with Google"
  Then I should see "Logged in successfully."
  When I follow "Add new movie"
  Then I should be on the Create New Movie page
  When I fill in "Title" with "Adventure Time"
  And I select "G" from "Rating"
  And I press "Save Changes"
  Then I should be on the RottenPotatoes home page
  And I should see "Adventure Time"

  When I follow "More about Adventure Time"
  Then I should be on the Details about Adventure Time page
  When I follow "Show All Review"
  Then I should be on the All Review Adventure Time page
  When I follow "Add Review"
  Then I should be on the New Review for Adventure Time page
  When I select "5" from "reviews[potatoes]"
  And I fill in "Comments" with "This movie is great"
  And I press "Create Review"
  Then I should be on the Details about Adventure Time page
  And I should see "Review successfully create."
  
  When I follow "Show All Review"
  Then I should be on the All Review Adventure Time page
  And I should not see "Add Review"
  When I follow "Show Review"
  Then I should be on the Review about Adventure Time page
  And I should see "5"
  And I should see "This movie is great"