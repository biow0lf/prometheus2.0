class Source < ActiveRecord::Base
  attr_accessible :branch_id, :filename, :size, :source, :srpm_id

  belongs_to :branch
  belongs_to :srpm

  validates :srpm, presence: true
  validates :branch, presence: true
  validates :source, presence: true
  validates :filename, presence: true
  validates :size, presence: true

  def import(branch, file, srpm)
    files = `rpmquery --qf '[%{BASENAMES}\t%{FILESIZES}\n]' -p #{file}`
    hsh = {}
    files.split("\n").each { |line| hsh[line.split("\t")[0]] = line.split("\t")[1] }
    sources = `rpmquery --qf '[%{SOURCE}\n]' -p #{file}`
    sourcees.each do |filename|
      content = `rpm2cpio "#{file}" | cpio -i --to-stdout "#{filename}"`
      source = Source.new
      source.source = content
      source.size = hsh[filename].to_i
      source.filename = filename
      source.branch_id = branch.id
      source.srpm_id = srpm.id
      source.save
    end
  end
end
