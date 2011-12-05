# encoding: utf-8

desc "Fix data"
task :fix_data => :environment do
  puts "#{Time.now.to_s}: fix"

  branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
  path = '/ALT/Sisyphus/files/SRPMS/*.src.rpm'

  Dir.glob(path).each do |file|
    Maintainer.import(`export LANG=C && rpm -qp --queryformat='%{PACKAGER}' #{file}`)
  end

  puts "#{Time.now.to_s}: done"
end


# desc "Fix data"
# task :fix_data => :environment do
#   puts Time.now.to_s + ": fix"
# 
# #  @srpms = Srpm.all
#   @srpms = Srpm.where(:builder_id => nil)
# 
#   @srpms.each do |srpm|
#     login = srpm.changelogname.split('<')[-1].split('>')[0].gsub(' at ', '@').split('@')[0].downcase
#     maintainer = Maintainer.where(:login => login).first
#     if maintainer
#       srpm.builder_id = maintainer.id
#       unless srpm.save
#         p "shit happens!!"
#       end
#     else
#       p "maintainer with login: '#{login}' not found"
#     end
#   end
# 
#   puts Time.now.to_s + ": end"
# end
