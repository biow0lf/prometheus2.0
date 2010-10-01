class Srpm < ActiveRecord::Base
  belongs_to :branch
  belongs_to :group
  has_many :packages
  
  has_many :acls, :foreign_key => 'package', :primary_key => 'name', :conditions => { :branch => '#{self.branch}', :vendor => '#{self.vendor}' }

  has_many :repocops, :foreign_key => 'srcname', :primary_key => 'name'

#  has_one :leader, :foreign_key => 'package', :primary_key => 'name', :conditions => { :branch => '#{self.branch}' }

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
        #srpm.group = rpm[1016]
        group = rpm[1016]
        gr = Group.first :conditions => { :name => group, :branch_id => br.id }
        srpm.group_id = gr.id
        srpm.group = group
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
end