# encoding: utf-8

class Rpm
  def self.check_md5(file)
    output = `rpm -K --nogpg #{file}`
    if !output.empty? && output.chop.split(': ').last == 'md5 OK'
      true
    else
      false
    end
  end
end

RPM = Rpm
