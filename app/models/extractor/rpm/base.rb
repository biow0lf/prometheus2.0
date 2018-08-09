# frozen_string_literal: true

require 'terrapin'

module Extractor
  module RPM
    class Base
      def initialize(file, command: 'rpm')
        @file = file
        @command = command
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

      def epoch
        @epoch ||= read_int('%{EPOCH}')
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

      def buildtime
        @buildtime ||= read_time('%{BUILDTIME}')
      end

      def filesize
        @filesize ||= File.size(@file)
      end

      def md5
        @md5 ||= Digest::MD5.file(@file).hexdigest
      end

      private

      def read_int(query)
        output = read(query)
        output ? output.to_i : output
      end

      def read_time(query)
        Time.at(read(query).to_i) # rubocop:disable Rails/TimeZone
      end

      def read(query)
        output = read_raw(query)

        output = nil if ['(none)', ''].include?(output)

        output
      end

      def read_raw(query)
        terrapin = Terrapin::CommandLine.new(@command, '-qp --queryformat=:query :file', environment: { 'LANG' => 'C' })

        terrapin.run(query: query, file: @file)
      rescue Terrapin::CommandNotFoundError
        raise Extractor::RPM::CommandNotFound
      end
    end
  end
end
