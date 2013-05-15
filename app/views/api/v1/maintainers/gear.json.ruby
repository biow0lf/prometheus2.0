hash = Hash.new

hash[:login]  = @maintainer.login
hash[:name]   = @maintainer.name

hash[:gears] = @gears.map do |gear|
  {
    repo: gear.repo,
    lastchange: gear.lastchange
  }
end

# => Gear(id: integer, repo: string, lastchange: datetime, created_at: datetime, updated_at: datetime, maintainer_id: integer, srpm_id: integer) 


hash.to_json
