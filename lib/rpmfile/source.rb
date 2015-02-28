module RPMFile # TODO: rename to RPM
  class Source < Base
    def filename
      @filename ||= "#{ name }-#{ version }-#{ release }.src.rpm"
    end
  end
end
