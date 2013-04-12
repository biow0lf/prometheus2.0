Given(/^we have branch "(.*?)"$/) do |name|
  Branch.create!(name: name, vendor: 'ALT Linux')
end

Given(/^we have maintainer "(.*?)"$/) do |name|
  Maintainer.create!(name: name, email: 'icesik@altlinux.org', login: 'icesik')
end

Given(/^we have group "(.*?)" in branch "(.*?)"$/) do |full_group_name, branch_name|
  branch = Branch.where(name: branch_name).first
  group1 = Group.create!(name: full_group_name.split('/')[0],
                         branch_id: branch.id,
                         parent_id: nil)
  group2 = Group.create!(name: full_group_name.split('/')[1],
                         branch_id: branch.id,
                         parent_id: group1.id)
end

Given(/^we have srpm "(.*?)" in branch "(.*?)"$/) do |srpm_name, branch_name|
  branch = Branch.where(name: branch_name).first
  group = Group.last
  srpm = Srpm.create!(branch_id: branch.id, name: srpm_name,
                      version: '3.4.11.1', release: 'alt1.1.1',
                      summary: 'short description',
                      description: 'long description',
                      group_id: group.id, license: 'GPLv2+',
                      url: 'http://openbox.org/', size: '831617',
                      filename: 'openbox-3.4.11.1-alt1.1.1.src.rpm',
                      md5: 'f87ff0eaa4e16b202539738483cd54d1',
                      buildtime: '2010-11-24 23:58:02 UTC',
                      vendor: 'ALT Linux Team', distribution: 'ALT Linux')
end

Given(/^we have in "(.*?)" in acls for package "(.*?)" in branch "(.*?)"$/) do |acl, package, branch|
  $redis.sadd("#{branch}:#{package}:acls", acl)
end
