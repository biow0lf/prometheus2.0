Feature: User sign in
  In order to get access to personal part of the site
  A user
  Should be able to sign in

  Scenario: User sign in
    Given I am signed up and confirmed as "email@example.com/password"
    When I go to the sign in page
    And I fill in "Email" with "email@example.com"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should see "Signed in successfully."
