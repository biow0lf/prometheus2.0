# encoding: utf-8

class Patch < ActiveRecord::Base
  belongs_to :branch
  belongs_to :srpm

  validates :srpm, presence: true
  validates :branch, presence: true
  validates :filename, presence: true
  validates :size, presence: true

  def self.import(branch, file, srpm)
    files = `rpmquery --qf '[%{BASENAMES}\t%{FILESIZES}\n]' -p #{file}`
    hsh = {}
    files.split("\n").each do |line|
      hsh[line.split("\t")[0]] = line.split("\t")[1]
    end
    patches = `rpmquery --qf '[%{PATCH}\n]' -p #{file}`
    patches.split("\n").each do |filename|
      patch = Patch.new

      # DON'T import patch if size is more than 512k
      if hsh[filename].to_i <= 1024 * 512
        content = `rpm2cpio "#{file}" | cpio -i --quiet --to-stdout "#{filename}"`
        patch.patch = content.force_encoding('BINARY')
      end

      patch.size = hsh[filename].to_i
      patch.filename = filename
      patch.branch_id = branch.id
      patch.srpm_id = srpm.id
      patch.save!
    end
  end
end

