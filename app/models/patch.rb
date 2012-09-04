# encoding: utf-8

class Patch < ActiveRecord::Base
  belongs_to :branch
  belongs_to :srpm

  validates :srpm, presence: true
  validates :branch, presence: true
  validates :patch, presence: true
  validates :filename, presence: true
  validates :size, presence: true

  def self.import(branch, file, srpm)
    files = `rpmquery --qf '[%{BASENAMES}\t%{FILESIZES}\n]' -p #{file}`
    hsh = {}
    files.split("\n").each { |line| hsh[line.split("\t")[0]] = line.split("\t")[1] }
    patches = `rpmquery --qf '[%{PATCH}\n]' -p #{file}`
    patches.each do |filename|
      content = `rpm2cpio "#{file}" | cpio -i --to-stdout "#{filename}"`
      patch = Patch.new
      patch.patch = content
      patch.size = hsh[filename].to_i
      patch.filename = filename
      patch.branch_id = branch.id
      patch.srpm_id = srpm.id
      patch.save
    end
  end
end

# irb(main):005:0> list1 = `rpmquery --qf '[%{BASENAMES}\t%{FILESIZES}\n]' -p /ALT/Sisyphus/files/SRPMS/openbox-3.5.0-alt1.1.src.rpm`
# [root@prometheus ~]# rpm --queryformat='[%{PATCH}\n]' -qp /ALT/Sisyphus/files/SRPMS/openbox-3.5.0-alt1.1.src.rpm

# irb(main):001:0> file = '/ALT/Sisyphus/files/SRPMS/openbox-3.5.0-alt1.1.src.rpm'
# => "/ALT/Sisyphus/files/SRPMS/openbox-3.5.0-alt1.1.src.rpm"
# irb(main):002:0> files = `rpmquery --qf '[%{BASENAMES}\t%{FILESIZES}\n]' -p #{file}`
# => "gnome-panel-control.pod\t1398\nkdetrayproxy.pod\t1133\nmenu.xml\t1134\nopenbox-3.3.1-alt-TheBear-theme.patch\t4097\nopenbox-3.4.4-alt-TheBear-theme-2.patch\t621\nopenbox-3.4.9-alt-desktop-file.patch\t329\nopenbox-3.5.0.tar.gz\t852170\nopenbox-alt-menu-rc.xml.in.patch\t554\nopenbox-gnome.wmsession\t212\nopenbox-icons.tar.bz2\t1697\nopenbox-kde.wmsession\t204\nopenbox.menu\t766\nopenbox.menu-method\t1674\nopenbox.spec\t10252\nopenbox.wmsession\t163\n"
# irb(main):003:0> 


# irb(main):004:0> hsh = {}
# => {}
# irb(main):005:0> files.split("\n").each {|line| hsh[line.split("\t")[0]] = line.split("\t")[1]}

# irb(main):009:0> patches = `rpmquery --qf '[%{PATCH}\n]' -p #{file}`

# .