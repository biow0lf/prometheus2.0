class Source < ActiveRecord::Base
  attr_accessible :branch_id, :filename, :size, :source, :srpm_id

  belongs_to :branch
  belongs_to :srpm

  validates :srpm, presence: true
  validates :branch, presence: true
  validates :filename, presence: true
  validates :size, presence: true

  def self.import(branch, file, srpm)
    files = `rpmquery --qf '[%{BASENAMES}\t%{FILESIZES}\n]' -p #{ file }`
    hsh = {}
    files.split("\n").each do |line|
      hsh[line.split("\t")[0]] = line.split("\t")[1]
    end
    sources = `rpmquery --qf '[%{SOURCE}\n]' -p #{ file }`
    sources.split("\n").each do |filename|
      source = Source.new

      # DON'T import source if size is more than 512k
      if hsh[filename].to_i <= 1024 * 512
        content = `rpm2cpio "#{ file }" | cpio -i --quiet --to-stdout "#{ filename }"`
        source.source = content.force_encoding('BINARY')
      end

      source.size = hsh[filename].to_i
      source.filename = filename
      source.branch_id = branch.id
      source.srpm_id = srpm.id
      source.save!
    end
  end

  def to_param
    filename
  end
end
