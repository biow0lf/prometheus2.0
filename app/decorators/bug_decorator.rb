class BugDecorator < Draper::Decorator
  delegate_all

  def as_json(*)
    {
      bug_id: bug_id,
      bug_status: bug_status,
      resolution: resolution,
      bug_severity: bug_severity,
      product: product,
      component: component,
      assigned_to: assigned_to,
      reporter: reporter,
      short_desc: short_desc,
      created_at: created_at.iso8601,
      updated_at: updated_at.iso8601
    }
  end

  def bugzilla_url
    "https://bugzilla.altlinux.org/#{ bug_id }"
  end

  def link_to_bugzilla
    h.link_to(bug_id, bugzilla_url, class: 'news')
  end
end
