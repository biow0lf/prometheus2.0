hash = Hash.new

hash[:name]      = @maintainer.name
hash[:email]     = @maintainer.email
hash[:login]     = @maintainer.login
hash[:time_zone] = @maintainer.time_zone
hash[:jabber]    = @maintainer.jabber
hash[:info]      = @maintainer.info
hash[:website]   = @maintainer.website
hash[:location]  = @maintainer.location

hash.to_json
