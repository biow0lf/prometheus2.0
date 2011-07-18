desc "Update md5 field for all srpms and rpms"
task :md5 => :environment do
  puts Time.now

  branch = Branch.where(:name => '4.0', :vendor => 'ALT Linux').first

  Srpm.where(:md5 => nil, :branch => branch).each do |srpm|
    file = "/ALT/4.0/files/SRPMS/#{srpm.filename}"
    md5 = `md5 #{file}`.split[3]
    srpm.update_attribute(:md5, md5)
  end

  # TODO:
  # Package.where(:md5 => nil, :branch => branch).each do |package|
  #   file = "/ALT/4.0/files/SRPMS/#{srpm.filename}"
  #   md5 = `md5 #{file}`.split[3]
  #   package.update_attribute(:md5, md5)
  # end

  puts Time.now
end
