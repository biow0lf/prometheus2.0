# frozen_string_literal: true

module Extractor
  module RPM
    class Binary < Base
      def as_json(*)
        {
          name: name,
          version: version,
          release: release,
          epoch: epoch,
          summary: summary,
          group: group,
          license: license,
          url: url,
          packager: packager,
          vendor: vendor,
          distribution: distribution,
          description: description,
          buildhost: buildhost,
          filename: filename,
          filesize: filesize,
          md5: md5,

          arch: arch,
          sourcerpm: sourcerpm
        }
      end

      def filename
        @filename ||= "#{ name }-#{ version }-#{ release }.#{ arch }.rpm"
      end

      def arch
        @arch ||= read('%{ARCH}')
      end

      def sourcerpm
        @sourcerpm ||= read('%{SOURCERPM}')
      end

      def requires
        @requires ||= Requires.new(@file).requires
      end

      def provides
        @provides ||= Provides.new(@file).provides
      end

      def obsoletes
        @obsoletes ||= Obsoletes.new(@file).obsoletes
      end

      def conflicts
        @conflicts ||= Conflicts.new(@file).conflicts
      end
    end
  end
end
