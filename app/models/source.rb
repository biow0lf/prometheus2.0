# frozen_string_literal: true

class Source < ApplicationRecord
   belongs_to :package, class_name: 'Package::Src'

   validates_presence_of :filename, :size

   def self.import rpm, package
      files = `rpm -q --qf '[%{BASENAMES}\t%{FILESIZES}\n]' -p #{ rpm.file }`
      hsh = {}
      files.split("\n").each do |line|
         hsh[line.split("\t")[0]] = line.split("\t")[1]
      end
      sources = `rpm -q --qf '[%{SOURCE}\n]' -p #{ rpm.file }`
      sources.split("\n").each do |filename|
         source = Source.new
         source.source = false
         source.size = hsh[filename].to_i
         source.filename = filename
         source.package_id = package.id
         source.save!
      end
   end

   def to_param
      filename
   end
end
