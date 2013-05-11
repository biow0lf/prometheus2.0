hash = Hash.new

hash[:branch]  = @branch.name
hash[:name]    = @srpm.name
hash[:version] = @srpm.version
hash[:release] = @srpm.release
hash[:epoch]   = @srpm.epoch

hash[:gears] = @gears.map do |gear|
  {
    srpm_id: gear.srpm_id,
    repo: gear.repo,
    lastchange: gear.lastchange,
    maintainer_id: gear.maintainer_id
  }
end

hash.to_json
