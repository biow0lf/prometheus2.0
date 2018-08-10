# frozen_string_literal: true

module Extractor
  module RPM
    class Requires < Base
      def requires
        output = []

        read_raw_requires.split("\n").each do |require|
          output << require.split("\t")
        end

        output
      end

      private

      def read_raw_requires
        read('[%{REQUIRENAME}\t%{REQUIREFLAGS:depflags}\t%{REQUIREVERSION}\n]')
      end
    end
  end
end
