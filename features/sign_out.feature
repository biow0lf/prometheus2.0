Feature: User sign out
  To protect my account from unauthorized access
  A signed in user
  Should be able to sign out

  Background:
    Given the following branch exists:
      | name     | vendor    |
      | Sisyphus | ALT Linux |

  Scenario: User sign out
    Given I am signed up and confirmed as "email@person.com"
    When I sign in as "email@person.com"
    Then I should see "Welcome, email@person.com!"
    And I sign out
    Then I should see "Signed out successfully."
