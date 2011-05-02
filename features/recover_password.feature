Feature: Recover password
  In order to get access to personal part of the site
  A user
  Should be able to recover lost password

  Scenario: Recover password
    Given I am signed up and confirmed as "email@example.com" with unknown password
    And a clear email queue
    When I go to the recover password page
    And I fill in "Email" with "email@example.com"
    And I press "Send me reset password instructions"
    Then I should see "You will receive an email with instructions about how to reset your password in a few minutes."
    And "email@example.com" should receive an email
    When I open the email
    Then I should see "Change my password" in the email body
    When I follow "Change my password" in the email
    Then I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Change my password"
    Then I should see "Your password was changed successfully. You are now signed in."
    And I should see "Welcome, email@example.com!"
