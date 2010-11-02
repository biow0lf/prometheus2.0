class Srpm < ActiveRecord::Base
  belongs_to :branch
  belongs_to :group
  has_many :packages, :dependent => :destroy
  has_one :leader, :dependent => :destroy
  has_one :maintainer, :through => :leader
  has_many :acls, :dependent => :destroy

  has_many :repocops, :foreign_key => 'srcname', :primary_key => 'name'

  def self.count_srpms_in_sisyphus
    Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first.srpms.count
  end

  def self.import_srpms(vendor, branch, path)
    br = Branch.where(:name => branch, :vendor => vendor).first
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
          group = br.groups.where(:name => rpm[1016], :parent_id => nil).first
        when 2
          group = br.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first
        when 3
          group = br.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first.children.where(:name => rpm[1016].split('/')[2]).first
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
        srpm.branch_id = br.id
        srpm.save!
      rescue RuntimeError
        puts "Bad .src.rpm: " + file
      end
    end
  end
  
  def self.import_srpm(vendor, branch, file)
    br = Branch.where(:name => branch, :vendor => vendor).first
    rpm = RPM::Package::open(file)
    if Srpm.count(:all, :conditions => { :branch_id => br.id, :name => rpm.name }) >= 1
      br.srpms.where(:name => rpm.name).first.packages.each do |package|
        $redis.del br.name + ":" + package.filename
      end
      $redis.del br.name + ":" + srpm.filename
      Srpm.destroy_all(:branch_id => br.id, :name => rpm.name)
    end
    srpm = Srpm.new
    srpm.filename = rpm.name + '-' + rpm.version.v + '-' + rpm.version.r + '.src.rpm'
    srpm.name = rpm.name
    srpm.version = rpm.version.v
    srpm.release = rpm.version.r
    
    case rpm[1016].split('/').count
    when 1
      group = br.groups.where(:name => rpm[1016], :parent_id => nil).first
    when 2
      group = br.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first
    when 3
      group = br.groups.where(:name => rpm[1016].split('/')[0], :parent_id => nil).first.children.where(:name => rpm[1016].split('/')[1]).first.children.where(:name => rpm[1016].split('/')[2]).first
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
    srpm.branch_id = br.id
    a = srpm.save!
    if a == true
      $redis.set br.name + ":" + srpm.filename, 1
      if br.name == 'Sisyphus' and br.vendor == 'ALT Linux'
        Leader.create_leader_for_package(br.vendor, br.name, 'http://git.altlinux.org/acl/list.packages.sisyphus', srpm.name)
      else
        # TODO!!!!
      end
    end
  end
end