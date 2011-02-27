desc "Fix data"
task :fix_data => :environment do
  puts Time.now.to_s + ": fix"

#  @srpms = Srpm.all
  @srpms = Srpm.where(:builder_id => nil)

  @srpms.each do |srpm|
    login = srpm.changelogname.split('<')[-1].split('>')[0].gsub(' at ', '@').split('@')[0].downcase
    maintainer = Maintainer.where(:login => login).first
    if maintainer
      srpm.builder_id = maintainer.id
      unless srpm.save
        p "shit happens!!"
      end
    else
      p "maintainer with login: '#{login}' not found"
    end
  end

  puts Time.now.to_s + ": end"
end
