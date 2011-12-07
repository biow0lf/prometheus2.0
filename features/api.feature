Feature: User API

  Background:
    Given the following branch exists:
      | id | name     | vendor    |
      | 0  | Sisyphus | ALT Linux |
    Given the following groups exists:
      | id | name              | parent_id | branch_id |
      | 0  | Graphical desktop |           | 0         |
      | 1  | Other             | 0         | 0         |
    Given the following srpm exists:
      | branch_id | name    | version  | release  | summary           | description      | group_id | license | url                 | size   | filename                          | md5                              | buildtime               | vendor         | distribution |
      | 0         | openbox | 3.4.11.1 | alt1.1.1 | short description | long description | 1        | GPLv2+  | http://openbox.org/ | 831617 | openbox-3.4.11.1-alt1.1.1.src.rpm | f87ff0eaa4e16b202539738483cd54d1 | 2010-11-24 23:58:02 UTC | ALT Linux Team | ALT Linux    |

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
        "vendor": "ALT Linux Team",
        "distribution": "ALT Linux",
        "repocop": "skip"
      }
      """

