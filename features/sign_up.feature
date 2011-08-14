Feature: Sign up
  In order to get access to personal part of the site
  A user
  Should be able to sign up

  Background:
    Given the following branch:
      | name   | Sisyphus  |
      | vendor | ALT Linux |

  Scenario: User sign up
    When I go to the sign up page
    And I fill in "Email" with "email@example.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign up"
    Then I should see "You have signed up successfully. However, we could not sign you in because your account is unconfirmed."
    And "email@example.com" should receive an email
    When I open the email
    Then I should see "Confirm my account" in the email body
    When I follow "Confirm my account" in the email
    And I should see "Your account was successfully confirmed. You are now signed in."
    And I should see "Welcome, email@example.com!"
