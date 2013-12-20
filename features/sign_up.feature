Feature: Sign up
  In order to get access to personal part of the site
  A user
  Should be able to sign up

  Background:
    Given we have branch "Sisyphus"

  Scenario: User sign up
    When I go to the sign up page
    And I fill in "Email" with "email@example.com"
    And I fill in "user_password" with "password"
    And I fill in "user_password_confirmation" with "password"
    And I press "Sign up"
    Then I should see "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
    And "email@example.com" should receive an email
    When I open the email
    Then I should see "Confirm my account" in the email body
    When I follow "Confirm my account" in the email
    And I should see "Your account was successfully confirmed."
