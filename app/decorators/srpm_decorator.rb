# frozen_string_literal: true

class SrpmDecorator < Draper::Decorator
  delegate_all

  def as_json(*)
    {
      id: id,
      branch_id: branch_id,
      branch: branch.name,
      name: name,
      version: version,
      release: release,
      epoch: epoch,
      summary: summary,
      license: license,
      group: groupname,
      group_id: group_id,
      url: url,
      description: description,
      buildtime: buildtime.iso8601,
      filename: filename,
      vendor: vendor,
      distribution: distribution,
      # changelogname: changelogname,
      # changelogtext: changelogtext,
      # changelogtime: changelogtime,
      md5: md5,
      builder_id: builder_id,
      size: size,
      repocop: repocop,
      created_at: created_at.iso8601,
      updated_at: updated_at.iso8601
    }
  end

  def short_url
    if url
      create_link
    else
      '&ndash;'.html_safe
    end
  end

  def evr
    if epoch
      "#{ epoch }:#{ version }-#{ release }"
    else
      "#{ version }-#{ release }"
    end
  end

  private

  def create_link
    if url.length > 27
      local_link_to("#{ url[0..26] }...")
    else
      local_link_to(url)
    end
  end

  def local_link_to(text)
    h.link_to(text, url, class: 'news', rel: 'nofollow')
  end
end
