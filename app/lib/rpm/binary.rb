# frozen_string_literal: true

module RPM
  class Binary < Base
    def filename
      @filename ||= "#{ name }-#{ version }-#{ release }.#{ arch }.rpm"
    end

    def arch
      @arch ||= read('%{ARCH}')
    end

    def sourcerpm
      @sourcerpm ||= read('%{SOURCERPM}')
    end
  end
end
