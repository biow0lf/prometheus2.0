require 'cocaine'

line = Cocaine::CommandLine.new("rpm", "-qp --queryformat=%{NAME} /Users/igor/opensource/prometheus2.0/spec/data/catpkt-1.0-alt5.src.rpm")
line.run # => "catpkt"
line.command_output # => "catpkt"
