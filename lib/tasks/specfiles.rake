namespace :sisyphus do
task :specfiles => :environment do
  puts Time.now

  branch = Branch.where(:name => 'Platform5', :vendor => 'ALT Linux').first

  srpms = branch.srpms.where(:specfile_id => nil)

  srpms.each do |srpm|
    file = "/ALT/p5/files/SRPMS/#{srpm.filename}"
    specfilename = `rpm -qp --queryformat=\"[%{FILEFLAGS} %{FILENAMES}\n]\" "#{file}" | grep \"32 \" | sed -e 's/32 //'`
    specfilename.strip!
    spec = `rpm2cpio "#{file}" | cpio -i --to-stdout "#{specfilename}"`

    specfile = Specfile.new
    specfile.srpm_id = srpm.id
    specfile.branch_id = branch.id
    specfile.spec = spec    
    unless specfile.save
      p "shit happens"
    end

    srpm.specfile_id = specfile.id
    unless srpm.save
        p "shit happens"
    end
  end

  puts Time.now
end
end
