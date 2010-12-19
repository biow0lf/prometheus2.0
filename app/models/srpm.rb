class Srpm < ActiveRecord::Base
  validates :branch_id, :presence => true
  validates :group_id, :presence => true

  belongs_to :branch
  belongs_to :group
  has_many :packages, :dependent => :destroy
  has_many :changelogs, :dependent => :destroy
  has_one :leader, :dependent => :destroy
  has_one :maintainer, :through => :leader
  has_many :acls, :dependent => :destroy
  has_one :specfile, :dependent => :destroy

  has_many :repocops, :foreign_key => 'srcname', :primary_key => 'name'

  def self.count_srpms_in(branch)
    Branch.where(:name => branch, :vendor => 'ALT Linux').first.srpms.count
  end

  def self.import_srpms(vendor, branch, path)
    b = Branch.where(:name => branch, :vendor => vendor).first
    Dir.glob(path).each do |file|
      begin
        rpm = RPM::Package::open(file)
        srpm = Srpm.new
        srpm.filename = rpm.name + '-' + rpm.version.v + '-' + rpm.version.r + '.src.rpm'
        srpm.name = rpm.name
        srpm.version = rpm.version.v
        srpm.release = rpm.version.r

        case rpm[1016].split('/').count
        when 1
          group = b.groups.where(:name => rpm[1016], :parent_id => nil).first
        when 2
          group = b.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first
        when 3
          group = b.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first.children.where(:name => rpm[1016].split('/')[2]).first
        else
          puts Time.now.to_s + ": too nested groups level"
        end

        srpm.group_id = group.id
        srpm.epoch = rpm[1003]
        srpm.summary = rpm[1004]
        srpm.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
        srpm.license = rpm[1014]
        srpm.url = rpm[1020]
        srpm.description = rpm[1005]
        srpm.vendor = rpm[1011]
        srpm.distribution = rpm[1010]
        srpm.buildtime = Time.at(rpm[1006])
        srpm.size = File.size(file)
        srpm.branch_id = b.id
        srpm.changelogtime = rpm.changelog.first.time
        srpm.changelogname = rpm.changelog.first.name
        srpm.changelogtext = rpm.changelog.first.text
        if srpm.save
          rpm.changelog.each do |c|
            changelog = Changelog.new
            changelog.srpm_id = srpm.id
            changelog.changelogname = c.name
            changelog.changelogtime = c.time
            changelog.changelogtext = c.text
            changelog.save!                                                                                                                                              
          end
          Specfile.import_specfile(file, srpm, b)
        end        
      rescue RuntimeError
        puts "RuntimeError at file: " + file
      end
    end
  end
  
  def self.import_srpm(vendor, branch, file)
    b = Branch.where(:name => branch, :vendor => vendor).first
    rpm = RPM::Package::open(file)
    if b.srpms.where(:name => rpm.name).all.count >= 1
      b.srpms.where(:name => rpm.name).first.packages.each do |package|
        $redis.del b.name + ":" + package.filename
      end
      $redis.del b.name + ":" + b.srpms.where(:name => rpm.name).first.filename
      Srpm.destroy_all(:branch_id => b.id, :name => rpm.name)
    end
    srpm = Srpm.new
    srpm.filename = rpm.name + '-' + rpm.version.v + '-' + rpm.version.r + '.src.rpm'
    srpm.name = rpm.name
    srpm.version = rpm.version.v
    srpm.release = rpm.version.r
    
    case rpm[1016].split('/').count
    when 1
      group = b.groups.where(:name => rpm[1016], :parent_id => nil).first
    when 2
      group = b.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first
    when 3
      group = b.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first.children.where(:name => rpm[1016].split('/')[2]).first
    else
      puts Time.now.to_s + ": too nested groups level"
    end

    srpm.group_id = group.id
    srpm.epoch = rpm[1003]
    srpm.summary = rpm[1004]
    srpm.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
    srpm.license = rpm[1014]
    srpm.url = rpm[1020]
    srpm.description = rpm[1005]
    srpm.vendor = rpm[1011]
    srpm.distribution = rpm[1010]
    srpm.buildtime = Time.at(rpm[1006])
    srpm.size = File.size(file)
    srpm.branch_id = b.id
    srpm.changelogtime = rpm.changelog.first.time
    srpm.changelogname = rpm.changelog.first.name
    srpm.changelogtext = rpm.changelog.first.text
    if srpm.save
      $redis.set b.name + ":" + srpm.filename, 1
      if b.name == 'Sisyphus' && b.vendor == 'ALT Linux'
        Leader.create_leader_for_package(b.vendor, b.name, 'http://git.altlinux.org/acl/list.packages.sisyphus', srpm.name)
        Acl.create_acls_for_package(b.vendor, b.name, 'http://git.altlinux.org/acl/list.packages.sisyphus', srpm.name)
      elsif b.name == '5.1' && b.vendor == 'ALT Linux'
        Leader.create_leader_for_package(b.vendor, b.name, 'http://git.altlinux.org/acl/list.packages.5.1', srpm.name)
        Acl.create_acls_for_package(b.vendor, b.name, 'http://git.altlinux.org/acl/list.packages.5.1', srpm.name)
      elsif b.name == '5.0' && b.vendor == 'ALT Linux'
        Leader.create_leader_for_package(b.vendor, b.name, 'http://git.altlinux.org/acl/list.packages.5.0', srpm.name)
        Acl.create_acls_for_package(b.vendor, b.name, 'http://git.altlinux.org/acl/list.packages.5.0', srpm.name)
      elsif b.name == '4.1' && b.vendor == 'ALT Linux'
        Leader.create_leader_for_package(b.vendor, b.name, 'http://git.altlinux.org/acl/list.packages.4.1', srpm.name)
        Acl.create_acls_for_package(b.vendor, b.name, 'http://git.altlinux.org/acl/list.packages.4.1', srpm.name)
      elsif b.name == '4.0' && b.vendor == 'ALT Linux'
        Leader.create_leader_for_package(b.vendor, b.name, 'http://git.altlinux.org/acl/list.packages.4.0', srpm.name)
        Acl.create_acls_for_package(b.vendor, b.name, 'http://git.altlinux.org/acl/list.packages.4.0', srpm.name)
      end
      #puts Time.now.to_s + ": updated '" + srpm.filename + "'"
      #puts Time.now.to_s + ": import changelog for '" + srpm.filename + "'"
      rpm.changelog.each do |c|
        changelog = Changelog.new
        changelog.srpm_id = srpm.id
        changelog.changelogname = c.name
        changelog.changelogtime = c.time
        changelog.changelogtext = c.text
        changelog.save!                                                                                                                                              
      end
      Specfile.import_specfile(file, srpm, b)
      #puts Time.now.to_s + ": imported changelog for '" + srpm.filename + "'"
    else
      puts Time.now.to_s + ": failed to update '" + srpm.filename + "'"
    end
  end
end
