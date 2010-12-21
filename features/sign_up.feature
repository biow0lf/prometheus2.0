Feature: Sign up
  In order to get access to personal part of the site
  A user
  Should be able to sign up

  Scenario: User sign up
    When I go to the sign up page
    And I fill in "Email" with "email@example.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign up"
    Then I should see "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."
    And a confirmation message should be sent to "email@example.com"
    And I should confirm my email "email@example.com"
