# frozen_string_literal: true

module RPM
  class SourceDecorator < Draper::Decorator
    delegate_all

    # TODO: add buildhost
    def as_json(*)
      {
        name: name,
        version: version,
        release: release,
        epoch: epoch,
        filename: filename,
        groupname: group,
        summary: summary,
        license: license,
        url: url,
        description: description,
        vendor: vendor,
        distribution: distribution,
        buildtime: buildtime,
        changelogtime: changelogtime,
        changelogname: changelogname,
        changelogtext: changelogtext,
        size: size, # TODO: change to #packagesize
        md5: md5
      }
    end
  end
end
