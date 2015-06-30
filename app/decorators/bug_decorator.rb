class BugDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
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
      created_at: created_at,
      updated_at: updated_at
    }
  end
end
