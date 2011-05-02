Feature: Recover password
  In order to get access to personal part of the site
  A user
  Should be able to recover lost password

  Scenario: Recover password
    Given I am signed up and confirmed as "email@example.com" with unknown password
    When I go to the recover password page
    And I fill in "Email" with "email@example.com"
    And I press "Send me reset password instructions"
