class BugDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    super only: [:bug_id, :bug_status, :resolution, :bug_severity, :product, :component, :assigned_to, :reporter, :short_desc],
          methods: [:updated_at, :created_at]
  end

  def bugzilla_url
    "https://bugzilla.altlinux.org/#{ bug_id }"
  end

  def link_to_bugzilla
    h.link_to(bug_id, bugzilla_url, class: 'news')
  end

  private
  def created_at
    model.created_at.iso8601
  end

  def updated_at
    model.updated_at.iso8601
  end
end
