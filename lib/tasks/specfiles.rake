task :specfiles => :environment do
  puts Time.now

  Dir.glob("/path/to/*.src.spec").each do |f|
  begin
    file = File.basename(f)

    srpm = Srpm.find :first, :conditions => { :filename => file[0..-5] + 'rpm' }

    file1 = File.open(f, 'rb')
    srpm.rawspec = file1.read

    srpm.save!

  rescue RuntimeError
    puts "Bad src.rpm -- " + f
  end
  end

  puts Time.now
end
