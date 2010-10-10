class Srpm < ActiveRecord::Base
  belongs_to :branch
  belongs_to :group
  has_many :packages
  has_one :leader
  has_one :maintainer, :through => :leader
  has_many :acls

  has_many :repocops, :foreign_key => 'srcname', :primary_key => 'name'

  def self.count_srpms_in_sisyphus
    Branch.first(:conditions => { :name => 'Sisyphus', :vendor => 'ALT Linux' }).srpms.count(:all)
  end

  def self.import_srpms(vendor, branch, path)
    br = Branch.first :conditions => { :name => branch, :vendor => vendor }
    Dir.glob(path).each do |file|
      begin
        rpm = RPM::Package::open(file)
        srpm = Srpm.new
        srpm.filename = rpm.name + '-' + rpm.version.v + '-' + rpm.version.r + '.src.rpm'
        srpm.name = rpm.name
        srpm.version = rpm.version.v
        srpm.release = rpm.version.r
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
        srpm.group_id = group.id
        srpm.epoch = rpm[1003]
        srpm.summary = rpm[1004]
        srpm.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
        srpm.license = rpm[1014]
        srpm.url = rpm[1020]
        srpm.description = rpm[1005]
        #srpm.vendor = rpm[1011]
        #srpm.distribution = rpm[1010]
        srpm.buildtime = Time.at(rpm[1006])
        srpm.size = File.size(file)
        srpm.branch_id = br.id
        srpm.save!
      rescue RuntimeError
        puts "Bad src.rpm -- " + file
      end
    end
  end
  
  def self.import_srpm(vendor, branch, file)
    br = Branch.first :conditions => { :name => branch, :vendor => vendor }
    rpm = RPM::Package::open(file)
    srpm = Srpm.new
    srpm.filename = rpm.name + '-' + rpm.version.v + '-' + rpm.version.r + '.src.rpm'
    srpm.name = rpm.name
    srpm.version = rpm.version.v
    srpm.release = rpm.version.r
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
    srpm.group_id = group.id
    srpm.epoch = rpm[1003]
    srpm.summary = rpm[1004]
    srpm.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
    srpm.license = rpm[1014]
    srpm.url = rpm[1020]
    srpm.description = rpm[1005]
    srpm.buildtime = Time.at(rpm[1006])
    srpm.size = File.size(file)
    srpm.branch_id = br.id
    srpm.save!    
    if srpm.epoch.nil?
      $redis.set br.name + ":" + srpm.name, srpm.version.to_s + "-" + srpm.release.to_s
    else
      $redis.set br.name + ":" + srpm.name, srpm.epoch.to_s + ":" + srpm.version.to_s + "-" + srpm.release.to_s
    end    
  end

  def self.update_srpm(vendor, branch, file)
    br = Branch.first :conditions => { :name => branch, :vendor => vendor }
    rpm = RPM::Package::open(file)
    Srpm.destroy_all(:branch_id => br.id, :name => rpm.name)
    srpm = Srpm.new
    srpm.filename = rpm.name + '-' + rpm.version.v + '-' + rpm.version.r + '.src.rpm'
    srpm.name = rpm.name
    srpm.version = rpm.version.v
    srpm.release = rpm.version.r
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
    srpm.group_id = group.id
    srpm.epoch = rpm[1003]
    srpm.summary = rpm[1004]
    srpm.summary = 'Broken' if rpm.name == 'openmoko_dfu-util'
    srpm.license = rpm[1014]
    srpm.url = rpm[1020]
    srpm.description = rpm[1005]
    srpm.buildtime = Time.at(rpm[1006])
    srpm.size = File.size(file)
    srpm.branch_id = br.id
    srpm.save!
    if srpm.epoch.nil?
      $redis.set br.name + ":" + srpm.name, srpm.version.to_s + "-" + srpm.release.to_s
    else
      $redis.set br.name + ":" + srpm.name, srpm.epoch.to_s + ":" + srpm.version.to_s + "-" + srpm.release.to_s
    end
  end
end