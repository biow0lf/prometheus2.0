require 'csv'

class Bug < ActiveRecord::Base
  attr_accessible :bug_id, :bug_status, :resolution, :bug_severity, :product,
                  :component, :assigned_to, :reporter, :short_desc

  def self.import(url)
    ActiveRecord::Base.transaction do
      Bug.delete_all
      data = `curl --silent "#{url}"`
      csv = CSV.parse(data)

      index = 0
      csv.each do |row|
        index += 1
        next if index == 1
        bug = Bug.new
        bug.bug_id = row[0]
        bug.bug_status = row[1]
        if row[2]
          bug.resolution = row[2]
        else
          bug.resolution = ''
        end
        bug.bug_severity = row[3]
        bug.product = row[4]
        bug.component = row[5]
        bug.assigned_to = row[6]
        bug.reporter = row[7]
        bug.short_desc = row[8]
        bug.save!
      end
    end
  end
end
