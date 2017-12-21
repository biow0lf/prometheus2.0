# frozen_string_literal: true

require 'console_reader'

module RPMFile
  class Base
    attr_reader :file
    attr_reader :reader

    RPM_STRING_TAGS = [:name, :version, :release, :summary, :group, :license,
                       :url, :packager, :vendor, :distribution, :description,
                       :buildhost, :changelogname, :changelogtext].freeze
    RPM_INT_TAGS = [:epoch].freeze
    RPM_TIME_TAGS = [:buildtime, :changelogtime].freeze

    def initialize(file, reader = ConsoleReader.new)
      @file = file
      @reader = reader
    end

    def read_raw(queryformat)
      command = 'rpm'
      opts = ['-qp', "--queryformat=#{ queryformat }", file]
      output = reader.run(command, opts)
      raise Errno::ENOENT if output[:exitstatus] != 0
      content = output[:stdout]
      return if content == '(none)' || content == ''
      content
    end

    def read_tag(tag)
      read_raw("%{#{ tag }}")
    end

    RPM_STRING_TAGS.each do |method|
      define_method(method) { read_tag(method.to_s.upcase) }
    end

    RPM_INT_TAGS.each do |method|
      define_method(method) do
        tag = read_tag(method.to_s.upcase)
        tag ? tag.to_i : tag
      end
    end

    RPM_TIME_TAGS.each do |method|
      define_method(method) { Time.at(read_tag(method.to_s.upcase).to_i) }
    end

    def filename
      raise NotImplementedError
    end

    def md5
      # TODO: Digest::MD5.file(file).hexdigest
      # make it more ruby and testable
      `md5sum #{ file }`.split.first
    end

    def size
      File.size(file)
    end
  end
end
