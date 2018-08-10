# frozen_string_literal: true

module Extractor
  module RPM
    class Provides < Base
      def provides
        output = []

        read_raw_provides.split("\n").each do |provide|
          output << provide.split("\t")
        end

        output
      end

      private

      def read_raw_provides
        read('[%{PROVIDENAME}\t%{PROVIDEFLAGS:depflags}\t%{PROVIDEVERSION}\n]')
      end
    end
  end
end
