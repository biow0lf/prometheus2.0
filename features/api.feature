Feature: User API

  Background:
    Given we have branch "Sisyphus"
    And we have group "Graphical desktop/Other" in branch "Sisyphus"
    And we have srpm "openbox" in branch "Sisyphus"
    And we have maintainer "Igor Zubkov"
    And we have acls "icesik" for source rpm "openbox" in branch "Sisyphus"

  Scenario: Source RPM info
    When I visit "/api/v1/Sisyphus/srpms/openbox"
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
        "buildtime": "2010-11-24T23:58:02.000Z",
        "vendor": "ALT Linux Team",
        "distribution": "ALT Linux",
        "repocop": "skip",
        "acls": "icesik"
      }
      """


#  Scenario: Changelog
#    When I visit "/en/Sisyphus/srpms/openbox/changelog"
#    Then the JSON response should be:
#      """
#        "branch": "Sisyphus",
#        "name": "openbox",
#        "version": "3.4.11.1",
#        "release": "alt1.1.1",
#        "epoch": null
#      """
