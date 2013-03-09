Feature: User sign in
  In order to get access to personal part of the site
  A user
  Should be able to sign in

  Background:
    Given we have branch "Sisyphus"

  Scenario: User sign in
    Given I am signed up and confirmed as "email@example.com"
    And I go to the sign in page
    When I fill in "Email" with "email@example.com"
    And I fill in "Password" with "password"
    And I press "Sign in"
#    Then I should see "Signed in successfully."
