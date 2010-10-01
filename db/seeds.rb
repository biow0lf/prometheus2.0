# add Sisyphus branch
branch = Branch.new
branch.vendor = 'ALT Linux'
branch.name = 'Sisyphus'
branch.url = 'Sisyphus'
branch.order_id = 0
branch.save!

# add SisyphusARM branch                                                                                                                                                      
branch = Branch.new
branch.vendor = 'ALT Linux'                                                                                                                                                           
branch.name = 'SisyphusARM'
branch.url = 'SisyphusARM'
branch.order_id = 1                                                                                                                                                           
branch.save!

# add Platform5 branch
branch = Branch.new
branch.vendor = 'ALT Linux'
branch.name = 'Platform5'
branch.url = 'Platform5'
branch.order_id = 2
branch.save!

# add 5.1 branch
branch = Branch.new
branch.vendor = 'ALT Linux'
branch.name = '5.1'
branch.url = '5.1'
branch.order_id = 3
branch.save!

# add 5.0 branch
branch = Branch.new
branch.vendor = 'ALT Linux'
branch.name = '5.0'
branch.url = '5.0'
branch.order_id = 4
branch.save!

# add 4.1 branch
branch = Branch.new
branch.vendor = 'ALT Linux'
branch.name = '4.1'
branch.url = '4.1'
branch.order_id = 5
branch.save!

# add 4.0 branch
branch = Branch.new
branch.vendor = 'ALT Linux'
branch.name = '4.0'
branch.url = '4.0'
branch.order_id = 6
branch.save!


## add Redora Rawhide
#branch = Branch.new
#branch.fullname = 'Rawhide'
#branch.urlname = 'Rawhide'
#branch.srpms_path = "/path/*.src.rpm"
#branch.altlinux = false
#branch.save!

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
Packager.create(:name => 'Alexey Shabalin', :email => 'shaba@altlinux.org', :login => 'shaba', :team => false)
Packager.create(:name => 'Valery Pipin', :email => 'vvpi@altlinux.org', :login => 'vvpi', :team => false)
Packager.create(:name => 'Pavel Boldin', :email => 'bp@altlinux.org', :login => 'bp', :team => false)
Packager.create(:name => 'Ruslan Hihin', :email => 'ruslandh@altlinux.org', :login => 'ruslandh', :team => false)
Packager.create(:name => 'Sergey Lebedev', :email => 'barabashka@altlinux.org', :login => 'barabashka', :team => false)
Packager.create(:name => 'Konstantin Pavlov', :email => 'thresh@altlinux.org', :login => 'thresh', :team => false)
Packager.create(:name => 'Alexey Morozov', :email => 'morozov@altlinux.org', :login => 'morozov', :team => false)
Packager.create(:name => 'Dmitry V. Levin', :email => 'ldv@altlinux.org', :login => 'ldv', :team => false)

# TODO: import teams before import srpm!
Packager.create(:name => 'TeX Development Team', :email => 'tex@packages.altlinux.org', :login => '@tex', :team => true)
Packager.create(:name => 'Connexion Development Team', :email => 'connexion@packages.altlinux.org', :login => '@connexion', :team => true)
Packager.create(:name => 'EVMS Development Team', :email => 'evms@packages.altlinux.org', :login => '@evms', :team => true)
Packager.create(:name => 'QA Team', :email => 'qa@packages.altlinux.org', :login => '@qa', :team => true)
Packager.create(:name => 'CPAN Team', :email => 'cpan@packages.altlinux.org', :login => '@cpan', :team => true)
Packager.create(:name => 'XFCE Team', :email => 'xfce@packages.altlinux.org', :login => '@xfce', :team => true)
