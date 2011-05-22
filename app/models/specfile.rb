class Specfile < ActiveRecord::Base
  validates :branch, :presence => true
  validates :srpm, :presence => true
  validates :spec, :presence => true

  belongs_to :srpm
  belongs_to :branch

  def self.import_specfile(file, srpm, branch)
    specfilename = `rpm -qp --queryformat=\"[%{FILEFLAGS} %{FILENAMES}\n]\" "#{file}" | grep \"32 \" | sed -e 's/32 //'`
    specfilename.strip!
    spec = `rpm2cpio "#{file}" | cpio -i --to-stdout "#{specfilename}"`.force_encoding("BINARY")

    specfile = Specfile.new
    specfile.srpm = srpm
    specfile.branch = branch
    specfile.spec = spec
    unless specfile.save
      puts "shit happens"
    end

    srpm.specfile = specfile
    unless srpm.save
      puts "shit happens"
    end
  end
end
