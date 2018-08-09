# frozen_string_literal: true

module Extractor
  module RPM
    class Source < Base
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
          buildtime: buildtime

          # lastchangelogtime: lastchangelogtime,
          # lastchangelogname: lastchangelogname,
          # lastchangelogtext: lastchangelogtext,
        }
      end

      def filename
        @filename ||= "#{ name }-#{ version }-#{ release }.src.rpm"
      end

      def build_requires
        @build_requires ||= BuildRequires.new(@file).build_requires
      end
    end
  end
end
