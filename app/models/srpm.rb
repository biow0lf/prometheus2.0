class Srpm < ActiveRecord::Base
  validates :branch, :presence => true
  validates :group, :presence => true

  belongs_to :branch
  belongs_to :group
  has_many :packages, :dependent => :destroy
  has_many :changelogs, :dependent => :destroy
  has_one :leader, :dependent => :destroy
  has_one :maintainer, :through => :leader
  has_many :acls, :dependent => :destroy
  has_one :specfile, :dependent => :destroy
  has_many :patches, :dependent => :destroy

  has_many :repocops, :foreign_key => 'srcname', :primary_key => 'name'
  has_one :repocop_patch, :foreign_key => 'name', :primary_key => 'name'

  define_index do
    indexes name, :sortable => true
    indexes summary
    indexes description
    indexes packages.name, :as => :packages_name, :sortable => true
    indexes packages.summary, :as => :packages_summary
    indexes packages.description, :as => :packages_description

    has branch_id
  end

  def to_param
    name
  end

  def self.count_srpms_in(branch_name)
    $redis.setnx("#{branch_name}:srpms:counter", Branch.where(:name => branch_name, :vendor => 'ALT Linux').first.srpms.count)
    $redis.get("#{branch_name}:srpms:counter")
  end

  def self.remove_old_srpms(vendor_name, branch_name, path)
    branch = Branch.where(:name => branch_name, :vendor => vendor_name).first
    branch.srpms.each do |srpm|
      unless File.exists?("#{path}#{srpm.filename}")
        puts "#{Time.now.to_s}: deleted '#{srpm.filename}'"
        $redis.decr("#{branch_name}:srpms:counter")
        srpm.destroy
      end
    end
  end

  def self.import_srpms(vendor_name, branch_name, path)
    branch = Branch.where(:name => branch_name, :vendor => vendor_name).first
    Dir.glob(path).each do |file|
      begin
        rpm = RPM::Package::open(file)
        srpm = Srpm.new
        srpm.filename = "#{rpm.name}-#{rpm.version.v}-#{rpm.version.r}.src.rpm"
        srpm.name = rpm.name
        srpm.version = rpm.version.v
        srpm.release = rpm.version.r

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

        srpm.group = group
        srpm.epoch = rpm[1003]
        srpm.summary = rpm[1004]
        # hack for very long summary in openmoko_dfu-util src.rpm
        srpm.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
        srpm.license = rpm[1014]
        srpm.url = rpm[1020]
        srpm.description = rpm[1005]
        srpm.vendor = rpm[1011]
        srpm.distribution = rpm[1010]
        srpm.buildtime = Time.at(rpm[1006])
        srpm.size = File.size(file)
        srpm.branch = branch
        srpm.changelogtime = rpm.changelog.first.time
        srpm.changelogname = rpm.changelog.first.name
        srpm.changelogtext = rpm.changelog.first.text
        if srpm.save
          rpm.changelog.each do |c|
            changelog = Changelog.new
            changelog.srpm = srpm
            changelog.changelogname = c.name
            changelog.changelogtime = c.time
            changelog.changelogtext = c.text
            changelog.save!
          end
          Specfile.import_specfile(file, srpm, branch)
          $redis.incr("#{branch_name}:srpms:counter")
        end
      rescue RuntimeError
        puts "RuntimeError at file: #{file}"
      rescue ArgumentError
        puts "ArgumentError at file: #{file}"
      end
    end
  end

  def self.import_srpm(vendor_name, branch_name, file)
    branch = Branch.where(:name => branch_name, :vendor => vendor_name).first
    rpm = RPM::Package::open(file)
    if branch.srpms.where(:name => rpm.name).all.count >= 1
      branch.srpms.where(:name => rpm.name).first.packages.each do |package|
        $redis.del branch.name + ":" + package.filename
      end
      $redis.del branch.name + ":" + branch.srpms.where(:name => rpm.name).first.filename
      Srpm.destroy_all(:branch_id => branch.id, :name => rpm.name)
    end
    srpm = Srpm.new
    srpm.filename = "#{rpm.name}-#{rpm.version.v}-#{rpm.version.r}.src.rpm"
    srpm.name = rpm.name
    srpm.version = rpm.version.v
    srpm.release = rpm.version.r

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

    srpm.group = group
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
    srpm.branch = branch
    srpm.changelogtime = rpm.changelog.first.time
    srpm.changelogname = rpm.changelog.first.name
    srpm.changelogtext = rpm.changelog.first.text
    if srpm.save
      $redis.set branch.name + ":" + srpm.filename, 1
      if branch.name == 'Sisyphus' && branch.vendor == 'ALT Linux'
        Leader.create_leader_for_package(branch.vendor, branch.name, 'http://git.altlinux.org/acl/list.packages.sisyphus', srpm.name)
        Acl.create_acls_for_package(branch.vendor, branch.name, 'http://git.altlinux.org/acl/list.packages.sisyphus', srpm.name)
      elsif branch.name == '5.1' && branch.vendor == 'ALT Linux'
        Leader.create_leader_for_package(branch.vendor, branch.name, 'http://git.altlinux.org/acl/list.packages.5.1', srpm.name)
        Acl.create_acls_for_package(branch.vendor, branch.name, 'http://git.altlinux.org/acl/list.packages.5.1', srpm.name)
      elsif branch.name == '5.0' && branch.vendor == 'ALT Linux'
        Leader.create_leader_for_package(branch.vendor, branch.name, 'http://git.altlinux.org/acl/list.packages.5.0', srpm.name)
        Acl.create_acls_for_package(branch.vendor, branch.name, 'http://git.altlinux.org/acl/list.packages.5.0', srpm.name)
      elsif branch.name == '4.1' && branch.vendor == 'ALT Linux'
        Leader.create_leader_for_package(branch.vendor, branch.name, 'http://git.altlinux.org/acl/list.packages.4.1', srpm.name)
        Acl.create_acls_for_package(branch.vendor, branch.name, 'http://git.altlinux.org/acl/list.packages.4.1', srpm.name)
      elsif branch.name == '4.0' && branch.vendor == 'ALT Linux'
        Leader.create_leader_for_package(branch.vendor, branch.name, 'http://git.altlinux.org/acl/list.packages.4.0', srpm.name)
        Acl.create_acls_for_package(branch.vendor, branch.name, 'http://git.altlinux.org/acl/list.packages.4.0', srpm.name)
      end
      #puts Time.now.to_s + ": updated '" + srpm.filename + "'"
      #puts Time.now.to_s + ": import changelog for '" + srpm.filename + "'"
      rpm.changelog.each do |c|
        changelog = Changelog.new
        changelog.srpm = srpm
        changelog.changelogname = c.name
        changelog.changelogtime = c.time
        changelog.changelogtext = c.text
        changelog.save!                                                                                                                                              
      end
      Specfile.import_specfile(file, srpm, branch)
      $redis.incr("#{branch_name}:srpms:counter")
      #puts Time.now.to_s + ": imported changelog for '" + srpm.filename + "'"
    else
      puts "#{Time.now.to_s}: failed to update '#{srpm.filename}'"
    end
  end
end
