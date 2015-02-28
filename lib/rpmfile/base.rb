require 'childprocess'
require 'tempfile'

module RPMFile # TODO: rename to RPM
  class Base
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def read_raw(queryformat)
      process = ChildProcess.build('rpm', '-qp', "--queryformat=#{ queryformat }", file)
      process.environment['LANG'] = 'C'
      process.io.stdout = Tempfile.new('child-output')
      process.start
      process.wait
      process.io.stdout.rewind
      content = process.io.stdout.read
      process.io.stdout.close
      process.io.stdout.unlink
      content = nil if content == '(none)'
      content = nil if content == ''
      content
    end

    def read_tag(tag)
      read_raw("%{#{ tag }}")
    end

    def name
      @name ||= read_tag('NAME')
    end

    def version
      @version ||= read_tag('VERSION')
    end

    def release
      @release ||= read_tag('RELEASE')
    end

    # TODO: epoch should be integer
    def epoch
      @epoch ||= read_tag('EPOCH')
    end

    def summary
      @summary ||= read_tag('SUMMARY')
    end

    def group
      @group ||= read_tag('GROUP')
    end

    def license
      @license ||= read_tag('LICENSE')
    end

    def url
      @url ||= read_tag('URL')
    end

    def packager
      @packager ||= read_tag('PACKAGER')
    end

    def vendor
      @vendor ||= read_tag('VENDOR')
    end

    def distribution
      @distribution ||= read_tag('DISTRIBUTION')
    end

    def description
      @description ||= read_tag('DESCRIPTION')
    end

    def buildhost
      @buildhost ||= read_tag('BUILDHOST')
    end

    def buildtime
      @buildtime ||= Time.at(read_tag('BUILDTIME').to_i)
    end

    def changelogname
      @changelogname ||= read_tag('CHANGELOGNAME')
    end

    def changelogtext
      @changelogtext ||= read_tag('CHANGELOGTEXT')
    end

    def changelogtime
      # TODO: @changelogtime ||= Time.at(read_tag('CHANGELOGTIME').to_i)
      @changelogtime ||= read_tag('CHANGELOGTIME')
    end

    def filename
      raise NotImplementedError
    end

    def md5
      # TODO: @md5 ||= Digest::MD5.file(file).hexdigest
      # make it more ruby and testable
      @md5 ||= `md5sum #{ file }`.split.first
    end

    # TODO: size should be integer, not string
    def size
      @size ||= (::File.size(file)).to_s
    end
  end
end
