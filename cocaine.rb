# frozen_string_literal: true

require 'cocaine'

line = Cocaine::CommandLine.new("rpm", "-qp --queryformat=%{NAME} /Users/biow0lf/opensource/prometheus2.0/spec/data/catpkt-1.0-alt5.src.rpm")
line.run # => "catpkt"
puts line.command_output # => "catpkt"

p Cocaine::CommandLine.send(:best_runner).class

line = Cocaine::CommandLine.new('date', '', environment: { 'LANG' => 'ru_RU.UTF-8' })
line.run
puts line.command_output
