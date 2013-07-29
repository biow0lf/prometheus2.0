namespace :clear do
  desc 'Clear all cache'
  task :cache => :environment do
    require 'open-uri'
    Rails.logger.info("#{Time.now.to_s}: Clear cache")
    ['en', 'ru', 'uk', 'br'].each do |locale|
      ActionController::Base.new.expire_fragment("#{locale}_top15")
    end
    branches = Branch.all
    branches.each do |branch|
      ['en', 'ru', 'uk', 'br'].each do |locale|
        ActionController::Base.new.expire_fragment("#{locale}_srpms_#{branch.name}_")
        pages_counter = (branch.srpms.where("srpms.created_at > '2010-11-09 09:00:00'").count / 50) + 1
        for page in 1..pages_counter do
          ActionController::Base.new.expire_fragment("#{locale}_srpms_#{branch.name}_#{page}")
        end
      end
    end
    Rails.logger.info("#{Time.now.to_s}: end")
  end
end
