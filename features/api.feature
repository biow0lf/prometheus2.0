Feature: User API

  Background:
    Given the following branch:
      | id     | 0         |
      | name   | Sisyphus  |
      | vendor | ALT Linux |
    Given the following groups:
      | id | name              | parent_id | branch_id |
      | 0  | Graphical desktop |           | 0         |
      | 1  | Other             | 0         | 0         |
    Given the following srpm:
      | branch_id   | 0                                 |
      | name        | openbox                           |
      | version     | 3.4.11.1                          |
      | release     | alt1.1.1                          |
      | summary     | short description                 |
      | description | long description                  |
      | group_id    | 1                                 |
      | license     | GPLv2+                            |
      | url         | http://openbox.org/               |
      | size        | 831617                            |
      | filename    | openbox-3.4.11.1-alt1.1.1.src.rpm |
      | md5         | f87ff0eaa4e16b202539738483cd54d1  |
      | buildtime   | 2010-11-24 23:58:02 UTC           |

  Scenario: Source rpm info
    When I visit "/en/Sisyphus/srpms/openbox"
    Then the JSON response should be:
      """
      {
        "branch": "Sisyphus",
        "name": "openbox",
        "version": "3.4.11.1",
        "release": "alt1.1.1",
        "epoch": null,
        "summary": "short description",
        "description": "long description",
        "group": "Graphical desktop/Other",
        "license": "GPLv2+",
        "url": "http://openbox.org/",
        "size": "831617",
        "filename": "openbox-3.4.11.1-alt1.1.1.src.rpm",
        "md5": "f87ff0eaa4e16b202539738483cd54d1",
        "buildtime": "2010-11-24 23:58:02 UTC",
        "repocop": "skip"
      }
      """

