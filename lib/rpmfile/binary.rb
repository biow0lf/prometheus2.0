# frozen_string_literal: true

module RPMFile
  class Binary < Base
    def filename
      "#{ name }-#{ version }-#{ release }.#{ arch }.rpm"
    end

    [:arch, :sourcerpm].each do |method|
      define_method(method) { read_tag(method.to_s.upcase) }
    end
  end
end
