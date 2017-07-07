module RPM
  class Source < Base
    def filename
      @filename ||= "#{ name }-#{ version }-#{ release }.src.rpm"
    end
  end
end
