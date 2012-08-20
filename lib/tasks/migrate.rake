# encoding: utf-8

namespace :migrate do
  desc 'Add builder_id to srpm'
  task :srpms => :environment do
    Srpm.select('id, changelogname').all.each do |srpm|
      email = srpm.changelogname.chop.split('<')[1].split('>')[0] rescue nil
      next if email.nil?
      email = Maintainer.new.fix_maintainer_email(email)
      maintainer = Maintainer.where(email: email).first
      srpm.update_attribute(:builder_id, maintainer.id)
    end
  end
end
