Feature: User can manually log in with google
 

@omniauth_test_success
Scenario: A user successfully signs in with google
    Given I am on the RottenPotatoes home page
    When I follow "Log In with Google"
    Then I should see "Logged in successfully."