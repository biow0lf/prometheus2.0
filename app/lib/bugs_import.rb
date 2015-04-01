require 'csv'

class BugsImport
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def execute
    ActiveRecord::Base.transaction do
      Bug.delete_all

        CSV.parse(data, headers: true) do |row|
          Bug.create!(row.to_hash)
      end
    end
  end

  def data
    `curl --cacert altlinux.ca --silent '#{ url }'`
  end
end
