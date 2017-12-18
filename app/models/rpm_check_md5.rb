# frozen_string_literal: true

class RPMCheckMD5
  def self.check_md5(file)
    output = `export LANG=C && rpm -K --nogpg #{ file }`
    if !output.empty? && output.chop.split(': ').last == 'md5 OK'
      true
    else
      false
    end
  end
end
