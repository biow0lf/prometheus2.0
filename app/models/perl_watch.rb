require 'open-uri'
require 'zlib'

class PerlWatch < ActiveRecord::Base
  validates :name, :presence => true

  def self.import_data(url)
    source = open(url)
    if url.split('.')[-1] == 'gz'
      gz = Zlib::GzipReader.new(source)
      result = gz.read
    else
      result = source
    end
    ActiveRecord::Base.transaction do
      PerlWatch.delete_all
      index = 0
      result.each_line do |line|
        index += 1
        next if index <= 9
        name = line.split[0]
        version = line.split[1]
        path = line.split[2]
        PerlWatch.create(:name => name, :version => version, :path => path)
      end
    end
  end
end
