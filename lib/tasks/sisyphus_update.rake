# namespace :sisyphus do
#   desc 'Update Sisyphus stuff'
#   task :update => :environment do
#     puts "#{Time.now.to_s}: Update Sisyphus stuff"
#     puts "#{Time.now.to_s}: update *.src.rpm from Sisyphus to database"
# 
#     branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
# 
#     Srpm.import_all(branch, '/ALT/Sisyphus/files/SRPMS/*.src.rpm')
# 
#     ActiveRecord::Base.transaction do
#       puts "#{Time.now.to_s}: update *.i586.rpm/*.x86_64.rpm/*.noarch.rpm from Sisyphus to database"
#       path_array = ['/ALT/Sisyphus/files/i586/RPMS/*.i586.rpm',
#                     '/ALT/Sisyphus/files/x86_64/RPMS/*.x86_64.rpm',
#                     '/ALT/Sisyphus/files/noarch/RPMS/*.noarch.rpm']
#       path_array.each do |path|
#         Dir.glob(path).each do |file|
#           begin
#             if !$redis.exists branch.name + ':' + file.split('/')[-1]
#               puts "#{Time.now.to_s}: update '#{file.split('/')[-1]}'"
#               Package.import_rpm(branch.vendor, branch.name, file)
#             end
#           rescue RuntimeError
#             puts "Bad .rpm: #{file}"
#           end
#         end
#       end
# 
#       Srpm.remove_old(branch, '/ALT/Sisyphus/files/SRPMS/')
#     end
# 
#     puts "#{Time.now.to_s}: expire cache"
#     ['en', 'ru', 'uk', 'br'].each do |locale|
#       ActionController::Base.new.expire_fragment("#{locale}_top15")
#       ActionController::Base.new.expire_fragment("#{locale}_srpms_#{branch.name}_")
#       pages_counter = branch.srpms.where("srpms.created_at > '2010-11-09 09:00:00'").count + 1
#       for page in 1..pages_counter do
#         ActionController::Base.new.expire_fragment("#{locale}_srpms_#{branch.name}_#{page}")
#       end
#     end
# 
#     puts "#{Time.now.to_s}: update acls in redis cache"
#     Acl.update_redis_cache('ALT Linux', 'Sisyphus', 'http://git.altlinux.org/acl/list.packages.sisyphus')
# 
#     puts "#{Time.now.to_s}: end"
#   end
# end
