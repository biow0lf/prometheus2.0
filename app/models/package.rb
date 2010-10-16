class Package < ActiveRecord::Base
  belongs_to :srpm
  belongs_to :branch
  belongs_to :group

  def self.import_rpm(vendor, branch, file)
    br = Branch.first :conditions => { :name => branch, :vendor => vendor }
    rpm = RPM::Package::open(file)
    package = Package.new
    package.filename = file.split('/')[-1]
    package.sourcepackage = rpm[1044]
    package.name = rpm.name
    package.version = rpm.version.v
    package.release = rpm.version.r
    package.arch = rpm.arch
    group0 = rpm[1016].split('/')[0]
    group1 = rpm[1016].split('/')[1]
    group2 = rpm[1016].split('/')[2]
    group = Group.first(:conditions => { :name => group0, :branch_id => br.id } )
    if group1 != nil
      group = Group.first(:conditions => { :name => group1, :branch_id => br.id, :parent_id => group.id })
      if group2 != nil
        group = Group.first(:conditions => { :name => group2, :branch_id => br.id, :parent_id => group.id })
      end
    end
    package.group_id = group.id
    package.epoch = rpm[1003]
    package.summary = rpm[1004]
    package.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
    package.license = rpm[1014]
    package.url = rpm[1020]
    package.description = rpm[1005]
    package.buildtime = Time.at(rpm[1006])
    package.size = File.size(file)
    package.branch_id = br.id
    srpm = Srpm.find :first, :conditions => { :filename => rpm[1044], :branch_id => br.id }
    package.srpm_id = srpm.id
    package.save!
    $redis.set br.name + ":" + package.filename, 1
  end

  def self.import_packages_i586(vendor, branch, path)
    br = Branch.first :conditions => { :name => branch, :vendor => vendor }
    Dir.glob(path).each do |file|
      begin
        rpm = RPM::Package::open(file)
        package = Package.new
        package.filename = rpm.name + '-' + rpm.version.v + '-' + rpm.version.r + '.i586.rpm'
        package.sourcepackage = rpm[1044]
        package.name = rpm.name
        package.version = rpm.version.v
        package.release = rpm.version.r
        package.arch = rpm.arch
        group0 = rpm[1016].split('/')[0]
        group1 = rpm[1016].split('/')[1]
        group2 = rpm[1016].split('/')[2]
        group = Group.first(:conditions => { :name => group0, :branch_id => br.id } )
        if group1 != nil
          group = Group.first(:conditions => { :name => group1, :branch_id => br.id, :parent_id => group.id })
          if group2 != nil
            group = Group.first(:conditions => { :name => group2, :branch_id => br.id, :parent_id => group.id })
          end
        end
        package.group_id = group.id
        package.epoch = rpm[1003]
        package.summary = rpm[1004]
        package.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
        package.license = rpm[1014]
        package.url = rpm[1020]
        package.description = rpm[1005]
        package.buildtime = Time.at(rpm[1006])
        package.size = File.size(file)
        package.branch_id = br.id
        srpm = Srpm.find :first, :conditions => { :filename => rpm[1044], :branch_id => br.id }
        package.srpm_id = srpm.id
        package.save!
      rescue RuntimeError
        puts "Bad src.rpm " + file
      end
    end
  end

  def self.import_packages_noarch(vendor, branch, path)
    br = Branch.first :conditions => { :name => branch, :vendor => vendor }
    Dir.glob(path).each do |file|
      begin
        rpm = RPM::Package::open(file)
        package = Package.new
        package.filename = rpm.name + '-' + rpm.version.v + '-' + rpm.version.r + '.noarch.rpm'
        package.sourcepackage = rpm[1044]
        package.name = rpm.name
        package.version = rpm.version.v
        package.release = rpm.version.r
        package.arch = rpm.arch
        group0 = rpm[1016].split('/')[0]
        group1 = rpm[1016].split('/')[1]
        group2 = rpm[1016].split('/')[2]
        group = Group.first(:conditions => { :name => group0, :branch_id => br.id } )
        if group1 != nil
          group = Group.first(:conditions => { :name => group1, :branch_id => br.id, :parent_id => group.id })
          if group2 != nil
            group = Group.first(:conditions => { :name => group2, :branch_id => br.id, :parent_id => group.id })
          end
        end
        package.group_id = group.id
        package.epoch = rpm[1003]
        package.summary = rpm[1004]
        package.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
        package.license = rpm[1014]
        package.url = rpm[1020]
        package.description = rpm[1005]
        package.buildtime = Time.at(rpm[1006])
        package.size = File.size(file)
        package.branch_id = br.id
        srpm = Srpm.find :first, :conditions => { :filename => rpm[1044], :branch_id => br.id }
        package.srpm_id = srpm.id
        package.save!
      rescue RuntimeError
        puts "Bad src.rpm " + file
      end
    end
  end

  def self.import_packages_x86_64(vendor, branch, path)
    br = Branch.first :conditions => { :name => branch, :vendor => vendor }
    Dir.glob(path).each do |file|
      begin
        rpm = RPM::Package::open(file)
        package = Package.new
        package.filename = rpm.name + '-' + rpm.version.v + '-' + rpm.version.r + '.x86_64.rpm'
        package.sourcepackage = rpm[1044]
        package.name = rpm.name
        package.version = rpm.version.v
        package.release = rpm.version.r
        package.arch = rpm.arch
        group0 = rpm[1016].split('/')[0]
        group1 = rpm[1016].split('/')[1]
        group2 = rpm[1016].split('/')[2]
        group = Group.first(:conditions => { :name => group0, :branch_id => br.id } )
        if group1 != nil
          group = Group.first(:conditions => { :name => group1, :branch_id => br.id, :parent_id => group.id })
          if group2 != nil
            group = Group.first(:conditions => { :name => group2, :branch_id => br.id, :parent_id => group.id })
          end
        end
        package.group_id = group.id
        package.epoch = rpm[1003]
        package.summary = rpm[1004]
        package.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
        package.license = rpm[1014]
        package.url = rpm[1020]
        package.description = rpm[1005]
        package.buildtime = Time.at(rpm[1006])
        package.size = File.size(file)
        package.branch_id = br.id
        srpm = Srpm.find :first, :conditions => { :filename => rpm[1044], :branch_id => br.id }
        package.srpm_id = srpm.id
        package.save!
      rescue RuntimeError
        puts "Bad src.rpm " + file
      end
    end
  end
  
  def self.import_packages_arm(vendor, branch, path)
    br = Branch.first :conditions => { :name => branch, :vendor => vendor }
    Dir.glob(path).each do |file|
      begin
        rpm = RPM::Package::open(file)
        package = Package.new
        package.filename = rpm.name + '-' + rpm.version.v + '-' + rpm.version.r + '.' + rpm.arch + '.rpm'
        package.sourcepackage = rpm[1044]
        package.name = rpm.name
        package.version = rpm.version.v
        package.release = rpm.version.r
        package.arch = rpm.arch
        group0 = rpm[1016].split('/')[0]
        group1 = rpm[1016].split('/')[1]
        group2 = rpm[1016].split('/')[2]
        group = Group.first(:conditions => { :name => group0, :branch_id => br.id } )
        if group1 != nil
          group = Group.first(:conditions => { :name => group1, :branch_id => br.id, :parent_id => group.id })
          if group2 != nil
            group = Group.first(:conditions => { :name => group2, :branch_id => br.id, :parent_id => group.id })
          end
        end
        package.group_id = group.id
        package.epoch = rpm[1003]
        package.summary = rpm[1004]
        package.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
        package.license = rpm[1014]
        package.url = rpm[1020]
        package.description = rpm[1005]
        package.buildtime = Time.at(rpm[1006])
        package.size = File.size(file)
        package.branch_id = br.id
        srpm = Srpm.find :first, :conditions => { :filename => rpm[1044], :branch_id => br.id }
        package.srpm_id = srpm.id
        package.save!
      rescue RuntimeError
        puts "Bad src.rpm " + file
      end
    end
  end
end