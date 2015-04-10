require 'console_reader'

module RPMFile
  class Base
    attr_reader :file
    attr_reader :reader

    def initialize(file, reader = ConsoleReader.new )
      @file = file
      @reader = reader
    end

    def read_raw(queryformat)
      command = 'rpm'
      opts = ['-qp', "--queryformat=#{ queryformat }", file]
      output = reader.run(command, opts)
      fail 'RPMFileNotFound' if output[:exitstatus] != 0
      content = output[:stdout]
      return nil if content == '(none)' || content == ''
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
      @changelogtime ||= Time.at(read_tag('CHANGELOGTIME').to_i)
    end

    def filename
      raise NotImplementedError
    end

    def md5
      # TODO: @md5 ||= Digest::MD5.file(file).hexdigest
      # make it more ruby and testable
      @md5 ||= `md5sum #{ file }`.split.first
    end

    def size
      @size ||= File.size(file)
    end
  end
end
