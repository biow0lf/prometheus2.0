# add Sisyphus branch
branch = Branch.new
branch.fullname = 'Sisyphus'
branch.urlname = 'Sisyphus'
branch.srpms_path = "/path/*.src.rpm"
branch.binary_x86_path = "/path/*.i586.rpm"
branch.noarch_path = "/path/*.noarch.rpm"
branch.binary_x86_64_path = "/path/*.x86_64.rpm"
branch.acls_url = 'http://git.altlinux.org/acl/list.packages.sisyphus'
branch.leaders_url = 'http://git.altlinux.org/acl/list.packages.sisyphus'
branch.acls_groups_url = 'http://git.altlinux.org/acl/list.groups.sisyphus'
branch.altlinux = true
branch.save!

# add Redora Rawhide
branch = Branch.new
branch.fullname = 'Rawhide'
branch.urlname = 'Rawhide'
branch.srpms_path = "/path/*.src.rpm"
branch.altlinux = false
branch.save!

# packager list
Packager.create(:name => 'Nobody', :email => 'noboby@altlinux.org', :login => '@nobody', :team => true)

Packager.create(:name => 'Igor Zubkov', :email => 'icesik@altlinux.org', :login => 'icesik', :team => false)
Packager.create(:name => 'Alexey Tourbin', :email => 'at@altlinux.org', :login => 'at', :team => false)
Packager.create(:name => 'Alexey I. Froloff', :email => 'raorn@altlinux.org', :login => 'raorn', :team => false)
Packager.create(:name => 'Eugeny A. Rostovtsev', :email => 'real@altlinux.org', :login => 'real', :team => false)
Packager.create(:name => 'Alexey Rusakov', :email => 'ktirf@altlinux.org', :login => 'ktirf', :team => false)
Packager.create(:name => 'Alex Gorbachenko', :email => 'algor@altlinux.org', :login => 'algor', :team => false)
Packager.create(:name => 'Andriy Stepanov', :email => 'stanv@altlinux.org', :login => 'stanv', :team => false)
Packager.create(:name => 'Anton Farygin', :email => 'rider@altlinux.org', :login => 'rider', :team => false)
Packager.create(:name => 'Igor Muratov', :email => 'migor@altlinux.org', :login => 'migor', :team => false)
