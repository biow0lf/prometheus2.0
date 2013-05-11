hash = Hash.new

hash[:branch] = @branch.name

hash[:srpms] = @srpms.map do |srpm|
  {
    name: srpm.name
  }
end

hash.to_json

