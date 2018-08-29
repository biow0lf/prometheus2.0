# frozen_string_literal: true

class PackageDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper

  delegate_all

  def as_json(*)
    {
      id: id,
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
      group: group.name,
      md5: md5,
      groupname: groupname,
      size: size,
      vendor: vendor,
      distribution: distribution,
      repocop: repocop,
      builder_id: builder.id,
      created_at: created_at.iso8601,
      updated_at: updated_at.iso8601
    }
  end

  def href
    "http://ftp.altlinux.org/pub/distributions/ALTLinux#{path}"
  end

  def human_size
    number_to_human_size(size)
  end

  def path
    "#{branches.first.path}/files/#{arch}/RPMS/#{filename}"
  end
end
