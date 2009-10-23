require 'open-uri'

namespace :sisyphus do
desc "Import repocop reports to database"
task :repocop => :environment do
  puts "import repocop reports"
  puts Time.now

  Repocop.transaction do
    Repocop.delete_all

    url = "http://repocop.altlinux.org/pub/repocop/prometeus2/prometeus2.txt"
    f = open(URI.escape(url)).read

    f.each_line do |line|

      srpm = Srpm.find :first, :select => "id", :conditions => { :branch => 'Sisyphus', :name => line.split('|||')[4] }
      if srpm != nil
        Repocop.create(:srpm_id    => srpm.id,
                       :name       => line.split('|||')[0],
                       :version    => line.split('|||')[1],
                       :release    => line.split('|||')[2],
                       :arch       => line.split('|||')[3],
                       :srcname    => line.split('|||')[4],
                       :srcversion => line.split('|||')[5],
                       :srcrel     => line.split('|||')[6],
                       :testname   => line.split('|||')[7],
                       :status     => line.split('|||')[8],
                       :message    => line.split('|||')[9]
                       )
      end
    end
  end

#  Repocop.all.each do |repocop|
#      srpm = Srpm.find :first, :conditions => { :branch => 'Sisyphus', :name => repocop.srcname }
#          if srpm != nil
#                repocop.srpm_id = srpm.id
#                      repocop.save!
#                          end
#                            end

  puts Time.now
end
end
