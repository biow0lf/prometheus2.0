require 'csv'

class Bug < ActiveRecord::Base
  def self.import(url)
    ActiveRecord::Base.transaction do
      Bug.delete_all
      data = `curl --cacert altlinux.ca --silent "#{ url }"`

      CSV.parse(data, headers: true) do |row|
        bug = Bug.new
        bug.bug_id = row['bug_id']
        bug.bug_status = row['bug_status']
        bug.resolution = row['resolution']
        bug.bug_severity = row['bug_severity']
        bug.product = row['product']
        bug.component = row['component']
        bug.assigned_to = row['assigned_to']
        bug.reporter = row['reporter']
        bug.short_desc = row['short_desc']
        bug.save!
      end
    end
  end
end
