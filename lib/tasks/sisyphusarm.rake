namespace :sisyphusarm do
  desc 'Update SisyphusARM stuff'
  task update: :environment do
    require 'open-uri'
    Rails.logger.info "#{ Time.now }: Update SisyphusARM stuff"
    if Redis.current.get('__SYNC__')
      exist = begin
                Process.kill(0, Redis.current.get('__SYNC__').to_i)
                true
              rescue
                false
              end
      if exist
        Rails.logger.info "#{ Time.now }: update is locked by another cron script"
        Process.exit!(true)
      else
        Rails.logger.info "#{ Time.now }: dead lock found and deleted"
        Redis.current.del('__SYNC__')
      end
    end
    Redis.current.set('__SYNC__', Process.pid)
    Rails.logger.info "#{ Time.now }: update *.src.rpm from SisyphusARM to database"
    branch = Branch.where(name: 'SisyphusARM', vendor: 'ALT Linux').first
    ThinkingSphinx::Deltas.suspend! if ENV['PROMETHEUS2_BOOTSTRAP'] == 'yes'
    Srpm.import_all(branch, '/ALT/Sisyphus/arm/SRPMS.all/*.src.rpm')
    Srpm.remove_old(branch, '/ALT/Sisyphus/arm/SRPMS.all/')
    Rails.logger.info "#{ Time.now }: end"
    Rails.logger.info "#{ Time.now }: update *.arm.rpm/*.noarch.rpm from SisyphusARM to database"
    pathes = ['/ALT/Sisyphus/files/arm/RPMS/*.rpm']
    Package.import_all(branch, pathes)
    ThinkingSphinx::Deltas.resume! if ENV['PROMETHEUS2_BOOTSTRAP'] == 'yes'
    Rails.logger.info "#{ Time.now }: end"
    # TODO: review and cleanup this code
    # Rails.logger.info "#{ Time.now }: expire cache"
    # ['en', 'ru', 'uk', 'br'].each do |locale|
    #   ActionController::Base.new.expire_fragment("#{ locale }_srpms_#{ branch.name }_")
    #   pages_counter = (branch.srpms.where("srpms.created_at > '2010-11-09 09:00:00'").count / 50) + 1
    #   for page in 1..pages_counter do
    #     ActionController::Base.new.expire_fragment("#{ locale }_srpms_#{ branch.name }_#{ page }")
    #   end
    # end
    # Rails.logger.info "#{ Time.now }: end"
    Rails.logger.info "#{ Time.now }: update time"
    # TODO: write to updated_at int
    Redis.current.set("#{ branch.name }:updated_at", Time.now.to_s)
    Rails.logger.info "#{ Time.now }: end"
    Redis.current.del('__SYNC__')
  end

  desc 'Import *.src.rpm from SisyphusARM to database'
  task srpms: :environment do
    require 'open-uri'
    Rails.logger.info "#{ Time.now }: import *.src.rpm from SisyphusARM to database"
    branch = Branch.where(name: 'SisyphusARM', vendor: 'ALT Linux').first
    Srpm.import_all(branch, '/ALT/Sisyphus/arm/SRPMS.all/*.src.rpm')
    Rails.logger.info "#{ Time.now }: end"
  end

  desc 'Import *.arm.rpm/*.noarch.rpm from SisyphusARM to database'
  task binary: :environment do
    require 'open-uri'
    Rails.logger.info "#{ Time.now }: import *.arm.rpm/*.noarch.rpm from SisyphusARM to database"
    branch = Branch.where(name: 'SisyphusARM', vendor: 'ALT Linux').first
    pathes = ['/ALT/Sisyphus/files/arm/RPMS/*.rpm']
    Package.import_all(branch, pathes)
    Rails.logger.info "#{ Time.now }: end"
  end
end
