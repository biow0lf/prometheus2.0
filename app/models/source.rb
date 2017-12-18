# frozen_string_literal: true

class Source < ApplicationRecord
  belongs_to :srpm

  validates :filename, presence: true

  validates :size, presence: true

  def self.import(file, srpm)
    files = `rpm -q --qf '[%{BASENAMES}\t%{FILESIZES}\n]' -p #{ file }`
    hsh = {}
    files.split("\n").each do |line|
      hsh[line.split("\t")[0]] = line.split("\t")[1]
    end
    sources = `rpm -q --qf '[%{SOURCE}\n]' -p #{ file }`
    sources.split("\n").each do |filename|
      source = Source.new

      # DON'T import source if size is more than 512k
      if hsh[filename].to_i <= 1024 * 512
        content = `rpm2cpio "#{ file }" | cpio -i --quiet --to-stdout "#{ filename }"`
        source.content = content.force_encoding('BINARY')
        source.source = true
      else
        source.source = false
      end

      source.size = hsh[filename].to_i
      source.filename = filename
      source.srpm_id = srpm.id
      source.save!
    end
  end

  def to_param
    filename
  end
end
