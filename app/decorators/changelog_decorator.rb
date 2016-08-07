class ChangelogDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    super only: [:id, :srpm_id, :changelogtime, :changelogname, :changelogtext], methods: [:created_at, :updated_at]
  end

  private
  def created_at
    model.created_at.iso8601
  end

  def updated_at
    model.updated_at.iso8601
  end
end
