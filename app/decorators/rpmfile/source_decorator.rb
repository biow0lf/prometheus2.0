module RPMFile
  class SourceDecorator < Draper::Decorator
    delegate_all

    def as_json(*args)
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
        size: size,
        md5: md5,
        changelogtime: changelogtime,
        changelogname: changelogname,
        changelogtext: changelogtext
      }
    end
  end
end
