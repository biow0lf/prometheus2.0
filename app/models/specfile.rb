class Specfile < ActiveRecord::Base
  validates :branch_id, :presence => true
  validates :srpm_id, :presence => true
  validates :spec, :presence => true
  
  belongs_to :srpm
  belongs_to :branch
  
  def self.import_specfile(file, srpm, branch)
    specfilename = `rpm -qp --queryformat=\"[%{FILEFLAGS} %{FILENAMES}\n]\" "#{file}" | grep \"32 \" | sed -e 's/32 //'`
    specfilename.strip!
    spec = `rpm2cpio "#{file}" | cpio -i --to-stdout "#{specfilename}"`
    
    specfile = Specfile.new
    specfile.srpm_id = srpm.id
    specfile.branch_id = branch.id
    specfile.spec = spec
    unless specfile.save
      puts "shit happens"
    end
    
    srpm.specfile_id = specfile.id
    unless srpm.save
      puts "shit happens"
    end    
  end
end
