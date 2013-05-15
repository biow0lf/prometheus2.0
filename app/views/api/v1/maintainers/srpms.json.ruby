hash = Hash.new

hash[:login]  = @maintainer.login
hash[:name]   = @maintainer.name
hash[:branch] = @branch.name

hash[:srpms] = @srpms.map do |srpm|
  {
    name: srpm
  }
end

hash.to_json
