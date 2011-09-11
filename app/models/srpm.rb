class Srpm < ActiveRecord::Base
  belongs_to :branch
  belongs_to :group

  validates :branch, :presence => true
  validates :group, :presence => true
  validates :md5, :presence => true

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
    indexes filename
    indexes packages.name, :as => :packages_name, :sortable => true
    indexes packages.summary, :as => :packages_summary
    indexes packages.description, :as => :packages_description
    indexes packages.filename, :as => :packages_filename
    indexes packages.sourcepackage, :as => :packages_sourcepackage

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
        srpm.packages.each do |package|
          $redis.del("#{branch.name}:#{package.filename}")
        end
        $redis.del("#{branch.name}:#{srpm.filename}")
        $redis.decr("#{branch_name}:srpms:counter")
        srpm.destroy
      end
    end
  end

  # def self.import_srpms(vendor_name, branch_name, path)
  #   branch = Branch.where(:name => branch_name, :vendor => vendor_name).first
  #   Dir.glob(path).each do |file|
  #     begin
  #       rpm = RPM::Package::open(file)
  #       srpm = Srpm.new
  #       srpm.summary = rpm[1004]
  #       # hack for very long summary in openmoko_dfu-util src.rpm
  #       srpm.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
  #     rescue RuntimeError
  #       puts "RuntimeError at file: #{file}"
  #     rescue ArgumentError
  #       puts "ArgumentError at file: #{file}"
  #     end
  #   end
  # end

  def self.import(branch, file)
    srpm = Srpm.new
    srpm.name = `rpm -qp --queryformat='%{NAME}' #{file}`
    srpm.version = `rpm -qp --queryformat='%{VERSION}' #{file}`
    srpm.release = `rpm -qp --queryformat='%{RELEASE}' #{file}`
    srpm.epoch = `rpm -qp --queryformat='%{EPOCH}' #{file}`
    # TODO: make test for this
    srpm.epoch = nil if srpm.epoch == '(none)'
    srpm.filename = "#{srpm.name}-#{srpm.version}-#{srpm.release}.src.rpm"

    group_name = `rpm -qp --queryformat='%{GROUP}' #{file}`
    Group.import(branch, group_name)
    group = Group.in_branch(branch, group_name)

    srpm.group_id = group.id
    srpm.summary = `rpm -qp --queryformat='%{SUMMARY}' #{file}`
    # TODO: test for this
    srpm.summary = 'Broken' if srpm.name == 'openmoko_dfu-util'
    srpm.license = `rpm -qp --queryformat='%{LICENSE}' #{file}`
    srpm.url = `rpm -qp --queryformat='%{URL}' #{file}`
    srpm.description = `rpm -qp --queryformat='%{DESCRIPTION}' #{file}`
    srpm.vendor = `rpm -qp --queryformat='%{VENDOR}' #{file}`
    srpm.distribution = `rpm -qp --queryformat='%{DISTRIBUTION}' #{file}`
    srpm.buildtime = Time.at(`rpm -qp --queryformat='%{BUILDTIME}' #{file}`.to_i)
    srpm.size = File.size(file)
    srpm.md5 = `/usr/bin/md5sum #{file}`.split[0]
    srpm.branch_id = branch.id
    srpm.changelogtime = Time.at(`rpm -qp --queryformat='%{CHANGELOGTIME}' #{file}`.to_i)
    srpm.changelogname = `rpm -qp --queryformat='%{CHANGELOGNAME}' #{file}`
    srpm.changelogtext = `rpm -qp --queryformat='%{CHANGELOGTEXT}' #{file}`
    if srpm.save
      $redis.set("#{branch.name}:#{srpm.filename}", 1)
      Changelog.import(branch, file, srpm)
      Specfile.import(branch, file, srpm)
      $redis.incr("#{branch.name}:srpms:counter")
      # TODO: import acl and leader
    else
      puts "#{Time.now.to_s}: failed to update '#{srpm.filename}'"
    end
  end

  def self.import_all(branch, path)
    Dir.glob(path).each do |file|
      unless $redis.exists("#{branch.name}:#{file.split('/')[-1]}")
        puts "#{Time.now.to_s}: import '#{file.split('/')[-1]}'"
        Srpm.import(branch, file)
      end
    end
  end

  # def self.import_srpm(vendor_name, branch_name, file)
  #   branch = Branch.where(:name => branch_name, :vendor => vendor_name).first
  #   rpm = RPM::Package::open(file)
  #   if branch.srpms.where(:name => rpm.name).all.count >= 1
  #     branch.srpms.where(:name => rpm.name).first.packages.each do |package|
  #       $redis.del("#{branch.name}:#{package.filename}")
  #     end
  #     $redis.del("#{branch.name}:#{branch.srpms.where(:name => rpm.name).first.filename}")
  #     Srpm.destroy_all(:branch_id => branch, :name => rpm.name)
  #   end
  # end
end
