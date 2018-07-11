# frozen_string_literal: true

class Specfile < ApplicationRecord
  belongs_to :srpm

  validates :spec, presence: true

  def self.import(file, srpm)
    specfilename = `rpm -qp --queryformat=\"[%{FILEFLAGS} %{FILENAMES}\n]\" "#{ file }" | grep \"32 \" | sed -e 's/32 //'`.strip
    spec = `rpm2cpio "#{ file }" | cpio -i --quiet --to-stdout "#{ specfilename }"`.dup.force_encoding('binary')

    specfile = Specfile.new
    specfile.srpm_id = srpm.id
    specfile.spec = spec
    specfile.save!
  end
end
