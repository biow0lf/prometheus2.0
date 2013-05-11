hash = Hash.new

hash[:branch] = @branch.name
hash[:name]   = @srpm.name

hash[:bugs] = @bugs.map do |bug|
  {
    bug_id: bug.bug_id,
    bug_status: bug.bug_status,
    resolution: bug.resolution,
    bug_severity: bug.bug_severity,
    product: bug.product,
    component: bug.component,
    assigned_to: bug.assigned_to,
    reporter: bug.reporter,
    short_desc: bug.short_desc
  }
end

hash.to_json
