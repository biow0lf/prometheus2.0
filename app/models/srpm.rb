class Srpm < ActiveRecord::Base

  has_many :acls, :foreign_key => 'package', :primary_key => 'name', :conditions => { :branch => '#{self.branch}' }

  has_many :repocops, :foreign_key => 'srcname', :primary_key => 'name'


  def self.count_srpms_in_sisyphus
    count :conditions => { :branch => 'Sisyphus' } #:vendor => 'ALT Linux' }
  end

  def self.import_srpms(vendor, branch)
    br = Branch.first :conditions => { :vendor => vendor , :name => branch }

    Dir.glob(br.srpms_path).each do |file|
    begin
      rpm = RPM::Package::open(file)
      srpm = Srpm.new
      srpm.filename = rpm.name + '-' + rpm.version.v + '-' + rpm.version.r + '.src.rpm'
      srpm.name = rpm.name
      srpm.version = rpm.version.v
      srpm.release = rpm.version.r
      srpm.group = rpm[1016]
      srpm.epoch = rpm[1003]
      srpm.summary = rpm[1004]
      srpm.license = rpm[1014]
      srpm.url = rpm[1020]
      srpm.description = rpm[1005]
      srpm.vendor = rpm[1011]
#      srpm.distribution = rpm[1010]
      srpm.buildtime = Time.at(rpm[1006])
      srpm.size = File.size(file)
      srpm.branch = br.name
      srpm.save!
    rescue RuntimeError
      puts "Bad src.rpm -- " + file
    end
    end
  end

end
