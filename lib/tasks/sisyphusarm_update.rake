namespace :sisyphusarm do
  namespace :update do
    desc "Update *.src.rpm from SisyphusARM to database"
    task :srpms => :environment do
      require 'rpm'
      puts Time.now.to_s + ": import src.rpm's"
      ActiveRecord::Base.transaction do
        ActiveRecord::Base.connection.execute("DELETE FROM srpms WHERE branch = 'SisyphusARM' AND vendor = 'ALT Linux'")
        Srpm.import_srpms 'ALT Linux', 'SisyphusARM', "/ALT/Sisyphus/arm/SRPMS.all/*.src.rpm"
      end
      puts Time.now.to_s + ": end"
    end

    desc "Update *.rpm from SisyphusARM to database"
    task :binary => :environment do
      require 'rpm'
      puts Time.now.to_s + ": import i586.rpm's"
      ActiveRecord::Base.transaction do
        ActiveRecord::Base.connection.execute("DELETE FROM packages WHERE branch = 'SisyphusARM' AND vendor = 'ALT Linux'")
        Package.import_packages_arm 'ALT Linux', 'SisyphusARM', "/ALT/Sisyphus/files/arm/RPMS/*.rpm"
      end
      puts Time.now.to_s + ": end"
    end
  end
end