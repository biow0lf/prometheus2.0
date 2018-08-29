# frozen_string_literal: true

class Specfile < ApplicationRecord
   belongs_to :package, class_name: 'Package::Src'

   validates :spec, presence: true

   def self.import rpm, package
      specfilename = `rpm -qp --queryformat=\"[%{FILEFLAGS} %{FILENAMES}\n]\" "#{ rpm.file }" | grep \"32 \" | sed -e 's/32 //'`.strip
      spec = `rpm2cpio "#{ rpm.file }" | cpio -i --quiet --to-stdout "#{ specfilename }"`.dup.force_encoding('binary')

      specfile = Specfile.new
      specfile.package_id = package.id
      specfile.spec = spec
      specfile.save!
   end
end
