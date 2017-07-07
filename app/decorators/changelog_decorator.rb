class ChangelogDecorator < Draper::Decorator
  delegate_all

  def as_json(*)
    {
      id: id,
      srpm_id: srpm_id,
      changelogtime: changelogtime,
      changelogname: changelogname,
      changelogtext: changelogtext,
      created_at: created_at.iso8601,
      updated_at: updated_at.iso8601
    }
  end
end
