# add Sisyphus branch
branch = Branch.new
branch.vendor = 'ALT Linux'
branch.name = 'Sisyphus'
branch.order_id = 0
branch.path = '/Sisyphus'
branch.save!

# add SisyphusARM branch
branch = Branch.new
branch.vendor = 'ALT Linux'
branch.name = 'SisyphusARM'
branch.order_id = 1
branch.path = '/Sisyphus'
branch.save!

# add Platform5 branch
branch = Branch.new
branch.vendor = 'ALT Linux'
branch.name = 'Platform5'
branch.order_id = 2
branch.path = '/p5/branch'
branch.save!

# add 5.1 branch
branch = Branch.new
branch.vendor = 'ALT Linux'
branch.name = '5.1'
branch.order_id = 3
branch.path = '/5.1/branch'
branch.save!

# add 5.0 branch
branch = Branch.new
branch.vendor = 'ALT Linux'
branch.name = '5.0'
branch.order_id = 4
branch.path = '/5.0/branch'
branch.save!

# add 4.1 branch
branch = Branch.new
branch.vendor = 'ALT Linux'
branch.name = '4.1'
branch.order_id = 5
branch.path = '/4.1/branch'
branch.save!

# add 4.0 branch
branch = Branch.new
branch.vendor = 'ALT Linux'
branch.name = '4.0'
branch.order_id = 6
branch.path = '/4.0/branch'
branch.save!

## add Redora Rawhide
#branch = Branch.new
#branch.fullname = 'Rawhide'
#branch.urlname = 'Rawhide'
#branch.srpms_path = "/path/*.src.rpm"
#branch.altlinux = false
#branch.save!

# Mirrors for Sisyphus
branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
Mirror.create(:branch_id => branch.id,
              :order_id => 0,
              :name => 'ftp://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'ftp://ftp.altlinux.org/pub/distributions/ALTLinux',
              :protocol => 'ftp')
Mirror.create(:branch_id => branch.id,
              :order_id => 1,
              :name => 'http://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'http://ftp.altlinux.org/pub/distributions/ALTLinux',
              :protocol => 'http')
Mirror.create(:branch_id => branch.id,
              :order_id => 2,
              :name => 'rsync://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'rsync://ftp.altlinux.org/ALTLinux',
              :protocol => 'rsync')

Mirror.create(:branch_id => branch.id,
              :order_id => 3,
              :name => 'ftp://ftp.linux.kiev.ua',
              :country => 'ua',
              :uri => 'ftp://ftp.linux.kiev.ua/pub/Linux/ALT',
              :protocol => 'ftp')
Mirror.create(:branch_id => branch.id,
              :order_id => 4,
              :name => 'http://ftp.linux.kiev.ua',
              :country => 'ua',
              :uri => 'http://ftp.linux.kiev.ua/pub/Linux/ALT',
              :protocol => 'http')
Mirror.create(:branch_id => branch.id,
              :order_id => 5,
              :name => 'rsync://ftp.linux.kiev.ua',
              :country => 'ua',
              :uri => 'rsync://ftp.linux.kiev.ua/ALTLinux',
              :protocol => 'rsync')

# Mirrors for SisyphusARM
branch = Branch.where(:name => 'SisyphusARM', :vendor => 'ALT Linux').first
Mirror.create(:branch_id => branch.id,
              :order_id => 0,
              :name => 'ftp://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'ftp://ftp.altlinux.org/pub/distributions/ALTLinux',
              :protocol => 'ftp')
Mirror.create(:branch_id => branch.id,
              :order_id => 1,
              :name => 'http://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'http://ftp.altlinux.org/pub/distributions/ALTLinux',
              :protocol => 'http')
Mirror.create(:branch_id => branch.id,
              :order_id => 2,
              :name => 'rsync://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'rsync://ftp.altlinux.org/ALTLinux',
              :protocol => 'rsync')

branch = Branch.where(:name => 'Platform5', :vendor => 'ALT Linux').first
Mirror.create(:branch_id => branch.id,
              :order_id => 0,
              :name => 'ftp://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'ftp://ftp.altlinux.org/pub/distributions/ALTLinux',
              :protocol => 'ftp')
Mirror.create(:branch_id => branch.id,
              :order_id => 1,
              :name => 'http://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'http://ftp.altlinux.org/pub/distributions/ALTLinux',
              :protocol => 'http')
Mirror.create(:branch_id => branch.id,
              :order_id => 2,
              :name => 'rsync://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'rsync://ftp.altlinux.org/ALTLinux',
              :protocol => 'rsync')

branch = Branch.where(:name => '5.1', :vendor => 'ALT Linux').first
Mirror.create(:branch_id => branch.id,
              :order_id => 0,
              :name => 'ftp://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'ftp://ftp.altlinux.org/pub/distributions/ALTLinux',
              :protocol => 'ftp')
Mirror.create(:branch_id => branch.id,
              :order_id => 1,
              :name => 'http://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'http://ftp.altlinux.org/pub/distributions/ALTLinux',
              :protocol => 'http')
Mirror.create(:branch_id => branch.id,
              :order_id => 2,
              :name => 'rsync://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'rsync://ftp.altlinux.org/ALTLinux',
              :protocol => 'rsync')

branch = Branch.where(:name => '5.0', :vendor => 'ALT Linux').first
Mirror.create(:branch_id => branch.id,
              :order_id => 0,
              :name => 'ftp://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'ftp://ftp.altlinux.org/pub/distributions/ALTLinux',
              :protocol => 'ftp')
Mirror.create(:branch_id => branch.id,
              :order_id => 1,
              :name => 'http://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'http://ftp.altlinux.org/pub/distributions/ALTLinux',
              :protocol => 'http')
Mirror.create(:branch_id => branch.id,
              :order_id => 2,
              :name => 'rsync://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'rsync://ftp.altlinux.org/ALTLinux',
              :protocol => 'rsync')

branch = Branch.where(:name => '4.1', :vendor => 'ALT Linux').first
Mirror.create(:branch_id => branch.id,
              :order_id => 0,
              :name => 'ftp://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'ftp://ftp.altlinux.org/pub/distributions/ALTLinux',
              :protocol => 'ftp')
Mirror.create(:branch_id => branch.id,
              :order_id => 1,
              :name => 'http://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'http://ftp.altlinux.org/pub/distributions/ALTLinux',
              :protocol => 'http')
Mirror.create(:branch_id => branch.id,
              :order_id => 2,
              :name => 'rsync://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'rsync://ftp.altlinux.org/ALTLinux',
              :protocol => 'rsync')


branch = Branch.where(:name => '4.0', :vendor => 'ALT Linux').first
Mirror.create(:branch_id => branch.id,
              :order_id => 0,
              :name => 'ftp://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'ftp://ftp.altlinux.org/pub/distributions/ALTLinux',
              :protocol => 'ftp')
Mirror.create(:branch_id => branch.id,
              :order_id => 1,
              :name => 'http://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'http://ftp.altlinux.org/pub/distributions/ALTLinux',
              :protocol => 'http')
Mirror.create(:branch_id => branch.id,
              :order_id => 2,
              :name => 'rsync://ftp.altlinux.org',
              :country => 'ru',
              :uri => 'rsync://ftp.altlinux.org/ALTLinux',
              :protocol => 'rsync')

# Mirror.create(:branch_id => branch.id, :order_id => 1, :country => 'ru',
#               :ftp => 'ftp://ftp.chg.ru/pub/Linux/ALTLinux',
#               :rsync => 'rsync://ftp.chg.ru/ALTLinux')
# 
# Mirror.create(:branch_id => branch.id, :order_id => 2, :country => 'us',
#               :ftp => 'ftp://ibiblio.org/pub/linux/distributions/altlinux',
#               :http => 'http://distro.ibiblio.org/pub/linux/distributions/altlinux',
#               :rsync => 'rsync://distro.ibiblio.org/distros/altlinux')
# 
# Mirror.create(:branch_id => branch.id, :order_id => 4, :country => 'ru',
#               :ftp => 'ftp://mirror.yandex.ru/altlinux',
#               :http => 'http://mirror.yandex.ru/altlinux',
#               :rsync => 'rsync://mirror.yandex.ru/altlinux')

# packager list
Maintainer.create(:name => 'Nobody', :email => 'noboby@altlinux.org', :login => '@nobody', :team => true)
Maintainer.create(:name => 'Eve R. Ybody', :email => 'everybody@altlinux.org', :login => '@everybody', :team => true)

Maintainer.create(:name => 'Igor Zubkov', :email => 'icesik@altlinux.org', :login => 'icesik', :team => false)
Maintainer.create(:name => 'Alexey Tourbin', :email => 'at@altlinux.org', :login => 'at', :team => false)
Maintainer.create(:name => 'Alexey I. Froloff', :email => 'raorn@altlinux.org', :login => 'raorn', :team => false)
Maintainer.create(:name => 'Eugeny A. Rostovtsev', :email => 'real@altlinux.org', :login => 'real', :team => false)
Maintainer.create(:name => 'Alexey Rusakov', :email => 'ktirf@altlinux.org', :login => 'ktirf', :team => false)
Maintainer.create(:name => 'Alex Gorbachenko', :email => 'algor@altlinux.org', :login => 'algor', :team => false)
Maintainer.create(:name => 'Andriy Stepanov', :email => 'stanv@altlinux.org', :login => 'stanv', :team => false)
Maintainer.create(:name => 'Anton Farygin', :email => 'rider@altlinux.org', :login => 'rider', :team => false)
Maintainer.create(:name => 'Igor Muratov', :email => 'migor@altlinux.org', :login => 'migor', :team => false)
Maintainer.create(:name => 'Mihail A. Pluzhnikov', :email => 'amike@altlinux.org', :login => 'amike', :team => false)
Maintainer.create(:name => 'Pavel V. Solntsev', :email => 'p_solntsev@altlinux.org', :login => 'p_solntsev', :team => false)
Maintainer.create(:name => 'Serge Ryabchun', :email => 'sr@altlinux.org', :login => 'sr', :team => false)
Maintainer.create(:name => 'Yurkovsky Andrey', :email => 'anyr@altlinux.org', :login => 'anyr', :team => false)
Maintainer.create(:name => 'Mikerin Sergey', :email => 'mikcor@altlinux.org', :login => 'mikcor', :team => false)
Maintainer.create(:name => 'Alexey Lokhin', :email => 'warframe@altlinux.org', :login => 'warframe', :team => false)
Maintainer.create(:name => 'Alexey Shabalin', :email => 'shaba@altlinux.org', :login => 'shaba', :team => false)
Maintainer.create(:name => 'Valery Pipin', :email => 'vvpi@altlinux.org', :login => 'vvpi', :team => false)
Maintainer.create(:name => 'Pavel Boldin', :email => 'bp@altlinux.org', :login => 'bp', :team => false)
Maintainer.create(:name => 'Ruslan Hihin', :email => 'ruslandh@altlinux.org', :login => 'ruslandh', :team => false)
Maintainer.create(:name => 'Sergey Lebedev', :email => 'barabashka@altlinux.org', :login => 'barabashka', :team => false)
Maintainer.create(:name => 'Konstantin Pavlov', :email => 'thresh@altlinux.org', :login => 'thresh', :team => false)
Maintainer.create(:name => 'Alexey Morozov', :email => 'morozov@altlinux.org', :login => 'morozov', :team => false)
Maintainer.create(:name => 'Dmitry V. Levin', :email => 'ldv@altlinux.org', :login => 'ldv', :team => false)
Maintainer.create(:name => 'Igor Androsov', :email => 'blake@altlinux.org', :login => 'blake', :team => false)
Maintainer.create(:name => 'Aleksandr Blokhin', :email => 'sass@altlinux.org', :login => 'sass', :team => false)
Maintainer.create(:name => 'Alexander Plikus', :email => 'plik@altlinux.org', :login => 'plik', :team => false)
Maintainer.create(:name => 'Vladimir Zhukov', :email => 'bertis@altlinux.org', :login => 'bertis', :team => false)
Maintainer.create(:name => 'Yura Zotov', :email => 'yz@altlinux.org', :login => 'yz', :team => false)
Maintainer.create(:name => 'Ilya Kuznetsov', :email => 'worklez@altlinux.org', :login => 'worklez', :team => false)
Maintainer.create(:name => 'Alex Yustasov', :email => 'yust@altlinux.org', :login => 'yust', :team => false)
Maintainer.create(:name => 'Konstantin Volckov', :email => 'goldhead@altlinux.org', :login => 'goldhead', :team => false)
Maintainer.create(:name => 'Andrey Orlov', :email => 'cray@altlinux.org', :login => 'cray', :team => false)
Maintainer.create(:name => 'Alexander V. Denisov', :email => 'rupor@altlinux.org', :login => 'rupor', :team => false)
Maintainer.create(:name => 'Peter Novodvorsky', :email => 'nidd@altlinux.org', :login => 'nidd', :team => false)
Maintainer.create(:name => 'George Kirik', :email => 'kga@altlinux.org', :login => 'kga', :team => false)
Maintainer.create(:name => 'Eugine V. Kosenko', :email => 'maverik@altlinux.org', :login => 'maverik', :team => false)
Maintainer.create(:name => 'Konstantin A. Lepikhov', :email => 'lakostis@altlinux.org', :login => 'lakostis', :team => false)
Maintainer.create(:name => 'George V. Kouryachy', :email => 'george@altlinux.org', :login => 'george', :team => false)
Maintainer.create(:name => 'Aitov Timur', :email => 'timonbl4@altlinux.org', :login => 'timonbl4', :team => false)
Maintainer.create(:name => 'Anton Chernyshov', :email => 'ach@altlinux.org', :login => 'ach', :team => false)
Maintainer.create(:name => 'Denis Baranov', :email => 'baraka@altlinux.org', :login => 'baraka', :team => false)
Maintainer.create(:name => 'Andrey Lykov', :email => 'droid@altlinux.org', :login => 'droid', :team => false)
Maintainer.create(:name => 'Grigory Fateyev', :email => 'greg@altlinux.org', :login => 'greg', :team => false)
Maintainer.create(:name => 'Anton Yanchenko', :email => 'lizzard@altlinux.org', :login => 'lizzard', :team => false)
Maintainer.create(:name => 'Konstantin Uvarin', :email => 'lodin@altlinux.org', :login => 'lodin', :team => false)
Maintainer.create(:name => 'Alex Radetsky', :email => 'rad@altlinux.org', :login => 'rad', :team => false)
Maintainer.create(:name => 'Wartan Hachaturow', :email => 'wart@altlinux.org', :login => 'wart', :team => false)
Maintainer.create(:name => 'Anton Pischulin', :email => 'letanton@altlinux.org', :login => 'letanton', :team => false)
Maintainer.create(:name => 'Pavel Isopenko', :email => 'pauli@altlinux.org', :login => 'pauli', :team => false)

# TODO: add @xen and @ha-cluster'

Maintainer.create(:name => 'TeX Development Team', :email => 'tex@packages.altlinux.org', :login => '@tex', :team => true)
Maintainer.create(:name => 'Connexion Development Team', :email => 'connexion@packages.altlinux.org', :login => '@connexion', :team => true)
Maintainer.create(:name => 'EVMS Development Team', :email => 'evms@packages.altlinux.org', :login => '@evms', :team => true)
Maintainer.create(:name => 'QA Team', :email => 'qa@packages.altlinux.org', :login => '@qa', :team => true)
Maintainer.create(:name => 'CPAN Team', :email => 'cpan@packages.altlinux.org', :login => '@cpan', :team => true)
Maintainer.create(:name => 'XFCE Team', :email => 'xfce@packages.altlinux.org', :login => '@xfce', :team => true)
Maintainer.create(:name => 'VIm Plugins Development Team', :email => 'vim-plugins@packages.altlinux.org', :login => '@vim-plugins', :team => true)
Maintainer.create(:name => 'FreeRadius Development Team', :email => 'freeradius@packages.altlinux.org', :login => '@freeradius', :team => true)
Maintainer.create(:name => 'FTN Development Team', :email => 'ftn@packages.altlinux.org', :login => '@ftn', :team => true)
