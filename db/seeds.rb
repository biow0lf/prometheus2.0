# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
#
#
# real@, Евгений Ростовцев, real@altlinux.org

# kill all branches from database
#Branch.delete_all

# add Sisyphus branch
branch = Branch.new
branch.fullname = 'Sisyphus'
branch.urlname = 'Sisyphus'
branch.http_srpms_url = 'http://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/SRPMS/'
branch.ftp_srpms_url =  'ftp://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/SRPMS/'
branch.http_noarch_url = 'http://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/noarch/RPMS/'
branch.ftp_noarch_url = 'ftp://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/noarch/RPMS/'
branch.http_i586_url = 'http://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/i586/RPMS/'
branch.ftp_i586_url = 'ftp://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/i586/RPMS/'
branch.http_x86_64_url = 'http://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/x86_64/RPMS/'
branch.ftp_x86_64_url = 'ftp://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/x86_64/RPMS/'
branch.acl_packages_url = 'http://git.altlinux.org/acl/list.packages.sisyphus'
branch.acl_groups_url = 'http://git.altlinux.org/acl/list.groups.sisyphus'
branch.save!


# add 4.0 branch
branch = Branch.new
branch.fullname = '4.0'
branch.urlname = 'Branch4'
#branch.http_srpms_url = 'http://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/SRPMS/'
#branch.ftp_srpms_url =  'ftp://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/SRPMS/'
#branch.http_noarch_url = 'http://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/noarch/RPMS/'
#branch.ftp_noarch_url = 'ftp://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/noarch/RPMS/'
#branch.http_i586_url = 'http://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/i586/RPMS/'
#branch.ftp_i586_url = 'ftp://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/i586/RPMS/'
#branch.http_x86_64_url = 'http://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/x86_64/RPMS/'
#branch.ftp_x86_64_url = 'ftp://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/x86_64/RPMS/'
#branch.acl_packages_url = 'http://git.altlinux.org/acl/list.packages.sisyphus'
#branch.acl_groups_url = 'http://git.altlinux.org/acl/list.groups.sisyphus'
branch.save!


# add Redora Rawhide
branch = Branch.new
branch.fullname = 'Rawhide'
branch.urlname = 'Rawhide'
#branch.http_srpms_url = 'http://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/SRPMS/'
#branch.ftp_srpms_url =  'ftp://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/SRPMS/'
#branch.http_noarch_url = 'http://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/noarch/RPMS/'
#branch.ftp_noarch_url = 'ftp://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/noarch/RPMS/'
#branch.http_i586_url = 'http://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/i586/RPMS/'
#branch.ftp_i586_url = 'ftp://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/i586/RPMS/'
#branch.http_x86_64_url = 'http://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/x86_64/RPMS/'
#branch.ftp_x86_64_url = 'ftp://ftp.altlinux.org/pub/distributions/ALTLinux/Sisyphus/files/x86_64/RPMS/'
#branch.acl_packages_url = 'http://git.altlinux.org/acl/list.packages.sisyphus'
#branch.acl_groups_url = 'http://git.altlinux.org/acl/list.groups.sisyphus'
branch.save!

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
