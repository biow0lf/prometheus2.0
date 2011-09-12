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

  def self.count_srpms(branch)
    counter = $redis.get("#{branch.name}:srpms:counter")
    if counter.nil?
      $redis.set("#{branch.name}:srpms:counter", branch.srpms.count)
      counter = $redis.get("#{branch.name}:srpms:counter")
    end
    counter
  end

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
    # hack for very long summary in openmoko_dfu-util src.rpm
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
        next unless RPM.check_md5(file)
        puts "#{Time.now.to_s}: import '#{file.split('/')[-1]}'"
        Srpm.import(branch, file)
      end
    end
  end

  def self.remove_old(branch, path)
    branch.srpms.each do |srpm|
      unless File.exists?("#{path}#{srpm.filename}")
        srpm.packages.each do |package|
          puts "#{Time.now.to_s}: delete '#{package.filename}' from redis cache"
          $redis.del("#{branch.name}:#{package.filename}")
        end
        puts "#{Time.now.to_s}: delete '#{srpm.filename}' from redis cache"
        $redis.del("#{branch.name}:#{srpm.filename}")
        srpm.destroy
        $redis.decr("#{branch.name}:srpms:counter")
      end
    end
  end
end
