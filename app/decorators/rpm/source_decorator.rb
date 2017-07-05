module RPM
  class SourceDecorator < Draper::Decorator
    delegate_all

    # TODO: add buildhost, md5
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
        size: packagesize
      }
    end
  end
end
