class SrpmImportAll
  attr_reader :branch

  def initialize(branch)
    @branch = branch
  end

  def execute
    Dir.glob("#{ branch.srpm_path }/*.src.rpm").each do |file|
      if file_can_be_imported?(file)
        puts "#{Time.now}: import '#{File.basename(file)}'"
        SrpmImport.new(branch, Srpm.new, RPMFile::Source.new(file)).import
      end
    end
  end

  def file_already_imported?(file)
    Redis.current.exists("#{ branch.name }:#{ File.basename(file) }")
  end

  def file_can_be_imported?(file)
    return if file_already_imported?(file)
    return unless File.exist?(file)
    Rpm.check_md5(file)
  end
end
