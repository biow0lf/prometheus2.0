hash = Hash.new

hash[:logins] = @maintainers.map do |maintainer|
  {
    login: maintainer.login
  }
end

hash.to_json
