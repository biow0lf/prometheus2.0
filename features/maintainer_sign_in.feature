Feature: Manageming maintainer profile
  In order to edit and update maintainer profile
  A maintainer
  Should be able to sign in and edit/update their profile

  Background:
    Given the following branch:
      | name   | Sisyphus  |
      | vendor | ALT Linux |
    And the following maintainer:
      | name  | Igor Zubkov         |
      | email | icesik@altlinux.org |
      | login | icesik              |
      | team  | false               |

  Scenario: Maintainer sign in
    Given I am signed up and confirmed as "icesik@altlinux.org"
    And I sign in as "icesik@altlinux.org"
    And I should see "Edit my maintainer profile"
  
  Scenario: User sign in
    Given I am signed up and confirmed as "email@example.com"
    And I sign in as "email@example.com"
    And I should not see "Edit my maintainer profile"

  Scenario: Update maintainer profile
    Given I am signed up and confirmed as "icesik@altlinux.org"
    And I sign in as "icesik@altlinux.org"
    When I go to my profile edit page
    And I fill in "Website/Blog:" with "http://biow0lf.pp.ua"
    And I fill in "Location:" with "Donetsk, Ukraine"
    And I select "Europe - Kiev" from "Time Zone:"
    And I fill in "Jabber ID:" with "icesik@jabber.ru"
    And I fill in "Info:" with "king dead long live"
    And I press "Update"
    Then I should see "http://biow0lf.pp.ua"
    And I should see "Donetsk, Ukraine"
    And I should see "Europe/Kiev"
    And I should see "icesik@jabber.ru"
    And I should see "king dead long live"
