class Specfile < ActiveRecord::Base
  belongs_to :srpm

  validates :srpm, presence: true
  validates :spec, presence: true

  def self.import(file, srpm)
    specfilename = `rpm -qp --queryformat=\"[%{FILEFLAGS} %{FILENAMES}\n]\" "#{file}" | grep \"32 \" | sed -e 's/32 //'`
    specfilename.strip!
    spec = `rpm2cpio "#{file}" | cpio -i --quiet --to-stdout "#{specfilename}"`
    spec.force_encoding('binary')

    specfile = Specfile.new
    specfile.srpm_id = srpm.id
    specfile.spec = spec
    specfile.save!
  end
end
