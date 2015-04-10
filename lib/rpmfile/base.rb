require 'console_reader'

module RPMFile
  class Base
    attr_reader :file
    attr_reader :reader

    RPM_STRING_TAGS = [:name, :version, :release, :summary, :group, :license,
                       :url, :packager, :vendor, :distribution, :description,
                       :buildhost, :changelogname, :changelogtext]
    RPM_INT_TAGS = [:epoch]
    RPM_TIME_TAGS = [:buildtime, :changelogtime]

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

    def method_missing(method, *_args, &_block)
      tag = nil
      if RPM_STRING_TAGS.include?(method)
        tag = read_tag(method.to_s.upcase)
      elsif RPM_INT_TAGS.include?(method)
        tag = read_tag(method.to_s.upcase)
        tag = tag.to_i if tag
      elsif RPM_TIME_TAGS.include?(method)
        tag = Time.at(read_tag(method.to_s.upcase).to_i)
      else
        super
      end
      tag
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
