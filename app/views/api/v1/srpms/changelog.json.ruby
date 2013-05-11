hash = Hash.new

hash[:branch]  = @branch.name
hash[:name]    = @srpm.name
hash[:version] = @srpm.version
hash[:release] = @srpm.release
hash[:epoch]   = @srpm.epoch

hash[:changelogs] = @changelogs.map do |changelog|
  {
    srpm_id: changelog.srpm_id,
    changelogtime: changelog.changelogtime,
    changelogname: changelog.changelogname,
    changelogtext: changelog.changelogtext
  }
end

hash.to_json
