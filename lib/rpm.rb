class Rpm
  def initialize(file)
    @file = file
  end

#  def file
#    @file
#  end

  def name
    @name ||= extract_tag('NAME')
  end

  def version
    @version ||= extract_tag('VERSION')
  end

  def release
    @release ||= extract_tag('RELEASE')
  end

  def filename
    "#{name}-#{version}-#{release}.src.rpm"
  end

  def epoch
    # TODO: make test for this
    # TODO: srpm.epoch = nil if srpm.epoch == '(none)'
    @epoch ||= extract_tag('EPOCH')
  end

  def summary
    @summary ||= extract_tag('SUMMARY')
  end

  def group
    @group ||= extract_tag('GROUP')
  end

  def packager
    @packager ||= extract_tag('PACKAGER')
  end

  def url
    @url ||= extract_tag('URL')
  end

  def license
    @license ||= extract_tag('LICENSE')
  end

  def vendor
    @vendor ||= extract_tag('VENDOR')
  end

  def distribution
    @distribution ||= extract_tag('DISTRIBUTION')
  end

  def description
    @description ||= extract_tag('DESCRIPTION')
  end

  def buildtime
    @buildtime ||= extract_tag('BUILDTIME')
  end

  def extract_tag(tag)
    `export LANG=C && rpm -qp --queryformat='%{#{ tag }}' #{ @file }`
  end

#  def none_is_nil(value)
#    nil if value == '(none)'
#  end

  def self.check_md5(file)
    output = `export LANG=C && rpm -K --nogpg #{file}`
    if !output.empty? && output.chop.split(': ').last == 'md5 OK'
      true
    end
  end
end
