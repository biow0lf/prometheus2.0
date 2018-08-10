# frozen_string_literal: true

module Extractor
  module RPM
    class BuildRequires < Base
      def build_requires
        output = []

        read_raw_build_requires.split("\n").each do |build_require|
          output << build_require.split("\t")
        end

        output
      end

      private

      def read_raw_build_requires
        read('[%{REQUIRENAME}\t%{REQUIREFLAGS:depflags}\t%{REQUIREVERSION}\n]')
      end
    end
  end
end
