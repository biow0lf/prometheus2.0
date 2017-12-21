# frozen_string_literal: true

require 'open3'

class ConsoleReader
  def run(command, opts)
    Open3.popen3({ 'LANG' => 'C' }, command, *opts) do |stdin, stdout, stderr, thr|
      {
        stdout: stdout.read,
        stderr: stderr.read,
        exitstatus: thr.value.exitstatus
      }
    end
  end
end
