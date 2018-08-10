# frozen_string_literal: true

module Extractor
  module RPM
    class Obsoletes < Base
      def obsoletes
        output = []

        read_raw_obsoletes.split("\n").each do |obsolete|
          output << obsolete.split("\t")
        end

        output
      end

      private

      def read_raw_obsoletes
        read('[%{OBSOLETENAME}\t%{OBSOLETEFLAGS:depflags}\t%{OBSOLETEVERSION}\n]')
      end
    end
  end
end
