Feature: User can not edit anything without log in


Background: Start from the Search form on the home page

  Given I am on the RottenPotatoes home page

Scenario: A user can not add any movies
    When I follow "Add new movie"
    Then I should see "You must be logged in."