class PerlWatch < ActiveRecord::Base
  validates :name, :presence => true

  def self.import_data(url)
    source = open(url)
    gz = Zlib::GzipReader.new(source)
    result = gz.read
    ActiveRecord::Base.transaction do
      PerlWatch.delete_all
      result.each_with_index do |line, index|
        return if index <= 8
        name = line.split[0]
        version = line.split[1]
        path = line.split[2]
        PerlWatch.create(:name => name, :version => version, :path => path)
      end
    end
  end
end
