require 'cocaine'

line = Cocaine::CommandLine.new("rpm", "-qp --queryformat=%{NAME} /Users/biow0lf/opensource/prometheus2.0/spec/data/catpkt-1.0-alt5.src.rpm")
line.run # => "catpkt"
puts line.command_output # => "catpkt"
