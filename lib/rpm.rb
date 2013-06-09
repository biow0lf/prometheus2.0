class Rpm
  def initialize(file)
    @file = file
  end

  def name
    @name ||= extract('NAME')
  end

  def version
    @version ||= extract('VERSION')
  end

  def release
    @release ||= extract('RELEASE')
  end

  def filename
    "#{name}-#{version}-#{release}.src.rpm"
  end

  def epoch
    @epoch ||= extract('EPOCH')
  end

  def summary
    @summary ||= extract('SUMMARY')
  end

  def group
    @group ||= extract('GROUP')
  end

  def packager
    @packager ||= extract('PACKAGER')
  end

  def url
    @url ||= extract('URL')
  end

  def license
    @license ||= extract('LICENSE')
  end

  def vendor
    @vendor ||= extract('VENDOR')
  end

  def distribution
    @distribution ||= extract('DISTRIBUTION')
  end

  def description
    @description ||= extract('DESCRIPTION')
  end

  def buildtime
    @buildtime ||= Time.at(extract('BUILDTIME').to_i)
  end

  def changelogtime
    @changelogtime ||= extract('CHANGELOGTIME')
  end

  def changelogname
    @changelogname ||= extract('CHANGELOGNAME')
  end

  def changelogtext
    @changelogtext ||= extract('CHANGELOGTEXT')
  end

  def sourcerpm
    @sourcerpm ||= extract('SOURCERPM')
  end

  def arch
    @arch ||= extract('ARCH')
  end

  def md5
    @md5 ||= `/usr/bin/md5sum #{ @file }`.split.first
  end

  def size
    File.size(@file)
  end

  def extract(tag)
    none_is_nil(`export LANG=C && rpm -qp --queryformat='%{#{ tag }}' #{ @file }`)
  end

  def none_is_nil(value)
    return nil if value == '(none)'
    value
  end

  def self.check_md5(file)
    output = `export LANG=C && rpm -K --nogpg #{file}`
    return true if !output.empty? && output.chop.split(': ').last == 'md5 OK'
    false
  end
end
