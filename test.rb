# frozen_string_literal: true

require 'open3'

opts = ['-qp', '--queryformat="%{NAME}"', 'spec/data/catpkt-1.0-alt5.src.rpm']

stdout = stderr = status = nil

#Open3.popen3("LANG=C", 'rpm', opts ) do |_stdin, _stdout, _stderr, _thr|
Open3.popen3({"LANG"=>"C"}, 'rpm', *opts ) do |_stdin, _stdout, _stderr, _thr|
  stdout = _stdout.read
  stderr = _stderr.read
  status = _thr.value
end

puts stdout
puts stderr
puts status
