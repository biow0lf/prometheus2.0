# encoding: utf-8

# namespace :platform5 do
#   desc "Update Platform5 stuff"
#   task :update => :environment do
#     require 'open-uri'
# 
#     branch = Branch.where(:name => 'Platform5', :vendor => 'ALT Linux').first
# 
#     ActiveRecord::Base.transaction do
#       puts "#{Time.now.to_s}: Update Platform5 stuff"
#       puts "#{Time.now.to_s}: update *.src.rpm from Platform5 to database"
#       path = '/ALT/p5/files/SRPMS/*.src.rpm'
#       Dir.glob(path).each do |file|
#         begin
#           if !$redis.exists branch.name + ":" + file.split('/')[-1]
#             puts "#{Time.now.to_s}: updating '#{file.split('/')[-1]}'"
#             Srpm.import_srpm(branch.vendor, branch.name, file)
#           end
#         rescue RuntimeError
#           puts "Bad .src.rpm: #{file}"
#         end
#       end
# 
#       puts "#{Time.now.to_s}: update *.i586.rpm/*.x86_64.rpm/*.noarch.rpm from Platform5 to database"
#       path_array = ['/ALT/p5/files/i586/RPMS/*.i586.rpm',
#                     '/ALT/p5/files/x86_64/RPMS/*.x86_64.rpm',
#                     '/ALT/p5/files/noarch/RPMS/*.noarch.rpm']
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
#       Srpm.remove_old(branch, '/ALT/p5/files/SRPMS/')
#     end
# 
#     puts "#{Time.now.to_s}: expire cache"
#     ['en', 'ru', 'uk', 'br'].each do |locale|
#       ActionController::Base.new.expire_fragment("#{locale}_srpms_#{branch.name}_")
#     end
# 
#     puts "#{Time.now.to_s}: end"
#   end
# end
