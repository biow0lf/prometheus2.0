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

Packager.create(:name => 'Mihail A. Pluzhnikov', :email => 'amike@altlinux.org', :login => 'amike', :team => false)
Packager.create(:name => 'Pavel V. Solntsev', :email => 'p_solntsev@altlinux.org', :login => 'p_solntsev', :team => false)
Packager.create(:name => 'Serge Ryabchun', :email => 'sr@altlinux.org', :login => 'sr', :team => false)
Packager.create(:name => 'Yurkovsky Andrey', :email => 'anyr@altlinux.org', :login => 'anyr', :team => false)
Packager.create(:name => 'Mikerin Sergey', :email => 'mikcor@altlinux.org', :login => 'mikcor', :team => false)
Packager.create(:name => 'Alexey Lokhin', :email => 'warframe@altlinux.org', :login => 'warframe', :team => false)
# TODO: import teams before import srpm!
Packager.create(:name => 'TeX Development Team', :email => 'tex@packages.altlinux.org', :login => '@tex', :team => true)
Packager.create(:name => 'Connexion Development Team', :email => 'connexion@packages.altlinux.org', :login => '@connexion', :team => true)
Packager.create(:name => 'EVMS Development Team', :email => 'evms@packages.altlinux.org', :login => '@evms', :team => true)


# who is this?
Packager.create(:name => 'Unknown', :email => 'vvpi@altlinux.org', :login => 'vvpi', :team => false)
