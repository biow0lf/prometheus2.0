Given /^we have branch "(.*?)"$/ do |name|
  Branch.create!(name: name, vendor: 'ALT Linux')
end

Given /^we have maintainer "(.*?)"$/ do |name|
  Maintainer.create!(name: name, email: 'icesik@altlinux.org', login: 'icesik', team: false)
end
