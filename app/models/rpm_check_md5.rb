# frozen_string_literal: true

class RPMCheckMD5
  def self.check_md5(file)
    Rpm::Base.new(file).has_valid_md5?
  end
end
