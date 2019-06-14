# frozen_string_literal: true

require 'cocaine'

module RPM
  class Base
    include Draper::Decoratable

    attr_reader :file

    def rpm
      self.class
    end

    def initialize(file)
      @file = file
    end

    def name
      @name ||= read('%{NAME}')
    end

    def version
      @version ||= read('%{VERSION}')
    end

    def release
      @release ||= read('%{RELEASE}')
    end

    def summary
      @summary ||= read('%{SUMMARY}')
    end

    def group
      @group ||= read('%{GROUP}')
    end

    def license
      @license ||= read('%{LICENSE}')
    end

    def url
      @url ||= read('%{URL}')
    end

    def packager
      @packager ||= read('%{PACKAGER}')
    end

    def vendor
      @vendor ||= read('%{VENDOR}')
    end

    def distribution
      @distribution ||= read('%{DISTRIBUTION}')
    end

    def description
      @description ||= read('%{DESCRIPTION}')
    end

    def buildhost
      @buildhost ||= read('%{BUILDHOST}')
    end

    def changelogname
      @changelogname ||= read('%{CHANGELOGNAME}')
    end

    def changelogtext
      @changelogtext ||= read('%{CHANGELOGTEXT}')
    end

    def changelogtime
      @changelogtime ||= read_time('%{CHANGELOGTIME}')
    end

    def buildtime
      @buildtime ||= read_time('%{BUILDTIME}')
    end

    def epoch
      @epoch ||= read_int('%{EPOCH}')
    end

    # TODO: broken on alt rpm 4.0.4
    def packagesize
      @packagesize ||= read_int('%{PACKAGESIZE}')
    end

    # TODO: drop in flavor of #packagesize
    def size
      @size ||= File.size(file)
    end

    def md5
      @md5 ||= Digest::MD5.file(file).hexdigest
    end

    private

    def read_int(tag)
      output = read(tag)
      output ? output.to_i : output
    end

    def read_time(tag)
      Time.zone.at(read(tag).to_i)
    end

    def read(tag)
      output = rpm.exec(
        line: '-qp --queryformat=:tag :file',
        tag: tag,
        file: file)

      output
    end

    class << self
      def version
        @version ||= exec('--version').split(/\s+/).last
      end

      def hash_of args
        if args.is_a?(String)
          { line: args }
        elsif args.is_a?(Hash)
          args
        else
          raise
        end
      end

      def exec args
        a_hash = hash_of(args)

        wrapper = Cocaine::CommandLine.new('rpm', a_hash[:line], environment: { 'LANG' => 'C' })

        result = wrapper.run(a_hash)
        result !~ /\A(\(none\)|)\z/ && result || nil
      rescue Cocaine::CommandNotFoundError
        Rails.logger.info('rpm command not found')

        nil
      rescue Cocaine::ExitStatusError
        Rails.logger.info('rpm exit status non zero')

        nil
      end
    end
  end
end
