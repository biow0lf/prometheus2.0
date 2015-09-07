class PackageDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    {
      id: id,
      srpm_id: srpm_id,
      name: name,
      version: version,
      release: release,
      epoch: epoch,
      arch: arch,
      summary: summary,
      license: license,
      url: url,
      description: description,
      buildtime: buildtime.iso8601,
      group_id: group_id,
      md5: md5,
      groupname: groupname,
      size: size,
      filename: filename,
      sourcepackage: sourcepackage,
      created_at: created_at.iso8601,
      updated_at: updated_at.iso8601
    }
  end
end
