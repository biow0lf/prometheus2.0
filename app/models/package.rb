class Package < ActiveRecord::Base
  belongs_to :branch
  belongs_to :srpm
  belongs_to :group

  validates :srpm, :presence => true
  validates :branch, :presence => true
  validates :group, :presence => true

  has_many :requires
  has_many :provides
  has_many :obsoletes
  has_many :conflicts

  def self.import_rpm(vendor_name, branch_name, file)
    branch = Branch.where(:name => branch_name, :vendor => vendor_name).first
    rpm = RPM::Package::open(file)
    if branch.srpms.where(:filename => rpm[1044]).count == 1
      package = Package.new
      package.filename = file.split('/')[-1]
      package.sourcepackage = rpm[1044]
      package.name = rpm.name
      package.version = rpm.version.v
      package.release = rpm.version.r
      package.arch = rpm.arch

      case rpm[1016].split('/').count
      when 1
        group = branch.groups.where(:name => rpm[1016], :parent_id => nil).first
      when 2
        group = branch.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first
      when 3
        group = branch.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first.children.where(:name => rpm[1016].split('/')[2]).first
      else
        puts "#{Time.now.to_s}: too nested groups level"
      end

      package.group = group
      package.epoch = rpm[1003]
      package.summary = rpm[1004]
      package.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
      package.license = rpm[1014]
      package.url = rpm[1020]
      package.description = rpm[1005]
      package.buildtime = Time.at(rpm[1006])
      package.size = File.size(file)
      package.branch = branch
      srpm = branch.srpms.where(:filename => rpm[1044]).first
      package.srpm = srpm
      if package.save
        $redis.set("#{branch.name}:#{package.filename}", 1)
        #puts Time.now.to_s + ": updated '" + package.filename + "'"
        # Provide.import_provides(rpm, package)
        # Require.import_requires(rpm, package)
        # Conflict.import_conflicts(rpm, package)
        # Obsolete.import_obsoletes(rpm, package)
      else
        puts "#{Time.now.to_s}: failed to update '#{package.filename}'"
      end
    else
      puts "#{Time.now.to_s}: srpm '#{rpm[1044]}' not found in db"
    end
  end

  def self.import_packages_i586(vendor_name, branch_name, path)
    branch = Branch.where(:name => branch_name, :vendor => vendor_name).first
    Dir.glob(path).each do |file|
      begin
        rpm = RPM::Package::open(file)
        if branch.srpms.where(:filename => rpm[1044]).count == 1
          package = Package.new
          package.filename = "#{rpm.name}-#{rpm.version.v}-#{rpm.version.r}.i586.rpm"
          package.sourcepackage = rpm[1044]
          package.name = rpm.name
          package.version = rpm.version.v
          package.release = rpm.version.r
          package.arch = rpm.arch

          case rpm[1016].split('/').count
          when 1
            group = branch.groups.where(:name => rpm[1016], :parent_id => nil).first
          when 2
            group = branch.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first
          when 3
            group = branch.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first.children.where(:name => rpm[1016].split('/')[2]).first
          else
            puts "#{Time.now.to_s}: too nested groups level"
          end

          package.group = group
          package.epoch = rpm[1003]
          package.summary = rpm[1004]
          package.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
          package.license = rpm[1014]
          package.url = rpm[1020]
          package.description = rpm[1005]
          package.buildtime = Time.at(rpm[1006])
          package.size = File.size(file)
          package.branch = branch
          srpm = branch.srpms.where(:filename => rpm[1044]).first
          package.srpm = srpm
          if package.save
            $redis.set("#{branch.name}:#{package.filename}", 1)
          end
        else
          puts "#{Time.now.to_s}: srpm '#{rpm[1044]}' not found in db"
        end
      rescue RuntimeError
        puts "RuntimeError at file: #{file}"
      end
    end
  end

  def self.import_packages_noarch(vendor_name, branch_name, path)
    branch = Branch.where(:name => branch_name, :vendor => vendor_name).first
    Dir.glob(path).each do |file|
      begin
        rpm = RPM::Package::open(file)
        if branch.srpms.where(:filename => rpm[1044]).count == 1
          package = Package.new
          package.filename = "#{rpm.name}-#{rpm.version.v}-#{rpm.version.r}.noarch.rpm"
          package.sourcepackage = rpm[1044]
          package.name = rpm.name
          package.version = rpm.version.v
          package.release = rpm.version.r
          package.arch = rpm.arch

          case rpm[1016].split('/').count
          when 1
            group = branch.groups.where(:name => rpm[1016], :parent_id => nil).first
          when 2
            group = branch.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first
          when 3
            group = branch.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first.children.where(:name => rpm[1016].split('/')[2]).first
          else
            puts "#{Time.now.to_s}: too nested groups level"
          end

          package.group = group
          package.epoch = rpm[1003]
          package.summary = rpm[1004]
          package.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
          package.license = rpm[1014]
          package.url = rpm[1020]
          package.description = rpm[1005]
          package.buildtime = Time.at(rpm[1006])
          package.size = File.size(file)
          package.branch = branch
          srpm = branch.srpms.where(:filename => rpm[1044]).first
          package.srpm = srpm
          if package.save
            $redis.set("#{branch.name}:#{package.filename}", 1)
          end
        else
          puts "#{Time.now.to_s}: srpm '#{rpm[1044]}' not found in db"
        end
      rescue RuntimeError
        puts "RuntimeError at file: #{file}"
      end
    end
  end

  def self.import_packages_x86_64(vendor_name, branch_name, path)
    branch = Branch.where(:name => branch_name, :vendor => vendor_name).first
    Dir.glob(path).each do |file|
      begin
        rpm = RPM::Package::open(file)
        if branch.srpms.where(:filename => rpm[1044]).count == 1
          package = Package.new
          package.filename = "#{rpm.name}-#{rpm.version.v}-#{rpm.version.r}.x86_64.rpm"
          package.sourcepackage = rpm[1044]
          package.name = rpm.name
          package.version = rpm.version.v
          package.release = rpm.version.r
          package.arch = rpm.arch

          case rpm[1016].split('/').count
          when 1
            group = branch.groups.where(:name => rpm[1016], :parent_id => nil).first
          when 2
            group = branch.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first
          when 3
            group = branch.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first.children.where(:name => rpm[1016].split('/')[2]).first
          else
            puts "#{Time.now.to_s}: too nested groups level"
          end

          package.group = group
          package.epoch = rpm[1003]
          package.summary = rpm[1004]
          package.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
          package.license = rpm[1014]
          package.url = rpm[1020]
          package.description = rpm[1005]
          package.buildtime = Time.at(rpm[1006])
          package.size = File.size(file)
          package.branch = branch
          srpm = branch.srpms.where(:filename => rpm[1044]).first
          package.srpm = srpm
          if package.save
            $redis.set("#{branch.name}:#{package.filename}", 1)
          end
        else
          puts "#{Time.now.to_s}: srpm '#{rpm[1044]}' not found in db"
        end
      rescue RuntimeError
        puts "RuntimeError at file: #{file}"
      end
    end
  end

  def self.import_packages_arm(vendor_name, branch_name, path)
    branch = Branch.where(:name => branch_name, :vendor => vendor_name).first
    Dir.glob(path).each do |file|
      begin
        rpm = RPM::Package::open(file)
        if branch.srpms.where(:filename => rpm[1044]).count == 1
          package = Package.new
          package.filename = "#{rpm.name}-#{rpm.version.v}-#{rpm.version.r}.#{rpm.arch}.rpm"
          package.sourcepackage = rpm[1044]
          package.name = rpm.name
          package.version = rpm.version.v
          package.release = rpm.version.r
          package.arch = rpm.arch

          case rpm[1016].split('/').count
          when 1
            group = branch.groups.where(:name => rpm[1016], :parent_id => nil).first
          when 2
            group = branch.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first
          when 3
            group = branch.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first.children.where(:name => rpm[1016].split('/')[2]).first
          else
            puts "#{Time.now.to_s}: too nested groups level"
          end

          package.group = group
          package.epoch = rpm[1003]
          package.summary = rpm[1004]
          package.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
          package.license = rpm[1014]
          package.url = rpm[1020]
          package.description = rpm[1005]
          package.buildtime = Time.at(rpm[1006])
          package.size = File.size(file)
          package.branch = branch
          srpm = branch.srpms.where(:filename => rpm[1044]).first
          package.srpm = srpm
          if package.save
            $redis.set("#{branch.name}:#{package.filename}", 1)
          end
        else
          puts "#{Time.now.to_s}: srpm '#{rpm[1044]}' not found in db"
        end
      rescue RuntimeError
        puts "RuntimeError at file: #{file}"
      end
    end
  end
end
