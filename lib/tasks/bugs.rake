require 'open-uri'
require 'csv'

$KCODE="UTF8"

namespace :sisyphus do
  desc "Import all bugs to database"
  task :bugs => :environment do
    puts Time.now.to_s + ": import bugs"

    begin
      ActiveRecord::Base.transaction do
        Bug.delete_all
        data = `curl --silent "https://bugzilla.altlinux.org/buglist.cgi?ctype=csv"`
        csv = CSV.parse(data)

        csv.each do |row|
          bug = Bug.new
          bug.bug_id = row[0]
          bug.bug_status = row[1]
          if row[2] != nil
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
    rescue => e
      puts Time.now.to_s + ': shit happen'
      puts e
    end

    puts Time.now.to_s + ": end"
  end
end
