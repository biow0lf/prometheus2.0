module RPMFile # TODO: rename to RPM
  class Binary < Base
    def arch
      @arch ||= read_tag('ARCH')
    end

    def filename
      @filename ||= "#{ name }-#{ version }-#{ release }.#{ arch }.rpm"
    end

    def sourcerpm
      @sourcerpm ||= read_tag('SOURCERPM')
    end
  end
end
