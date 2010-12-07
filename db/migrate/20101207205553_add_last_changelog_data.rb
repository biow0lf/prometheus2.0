class AddLastChangelogData < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      srpms = Srpm.scoped
      srpms.each do |srpm|
        changelog = srpm.changelogs.order('changelogtime DESC').first
        
        srpm.changelogtime = changelog.changelogtime
        srpm.changelogname = changelog.changelogname
        srpm.changelogtext = changelog.changelogtext        
        unless srpm.save
          p "shit happens!"
        end
      end
    end
  end

  def self.down
  end
end
