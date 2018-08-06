# frozen_string_literal: true

module Extractor
  module RPM
    class Conflicts < Base
      def conflicts
        output = []

        read_raw_conflicts.split("\n").each do |conflict|
          output << conflict.split("\t")
        end

        output
      end

      private

      def read_raw_conflicts
        read('[%{CONFLICTNAME}\t%{CONFLICTFLAGS:depflags}\t%{CONFLICTVERSION}\n]')
      end
    end
  end
end
