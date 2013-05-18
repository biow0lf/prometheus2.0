namespace :migrate do
  desc 'Update all srpms with groupname'
  task :update_groupname => :environment do

    Srpm.where(groupname: nil).each do |srpm|
      srpm.update_column(:groupname, srpm.group.full_name)
    end

  end
end

