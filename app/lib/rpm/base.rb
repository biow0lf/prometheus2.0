# frozen_string_literal: true

require 'cocaine'

class Rpm::Base
   include Draper::Decoratable

   attr_reader :file

   # TODO: packagesize is broken on alt rpm 4.0.4
   TAGS = {
      %i(name version release summary group license sigmd5
         url packager vendor distribution description
         buildhost arch sourcerpm)                             => ->(value) { value.present? && value != "(none)" && value || nil },
      %i(epoch)                                                => ->(value) { value.present? && value != "(none)" && value.to_i || nil },
      %i(buildtime)                                            => ->(value) { value.present? && value != "(none)" && Time.zone.at(value.to_i) || nil },
   }.map { |(tags, method)| tags.map { |tag| [tag, method] } }.flatten(1).to_h

   def rpm
      self.class
   end

   def initialize(file)
      @file = file
   end

   def get method
      @info ||= (
         data = read(TAGS.keys.map { |k| "%{#{k}}".upcase }.join("\x01\x02"))
         [ TAGS.keys, data.split("\u0001\u0002") ].transpose.map {|key, value| [key, TAGS[key][value]] }.to_h )

      @info[method]
   end

   TAGS.keys.each do |method|
      define_method(method) { get(method) }
   end

   # TODO: drop in flavor of #packagesize
   def size
      @size ||= File.size(file)
   end

   def md5
      @md5 ||= Digest::MD5.file(file).hexdigest
   end

   def arch
      sourcerpm && read(:arch) || 'src'
   end

   def change_log
      output = read("[%{CHANGELOGTIME}\n#{'+'*10}\n%{CHANGELOGNAME}\n#{'+'*10}\n%{CHANGELOGTEXT}\n#{'@'*10}\n]")

      records = output.to_s.dup.force_encoding('binary').split("\n#{'@'*10}\n")
      records.map { |r| r.split("\n#{'+'*10}\n") }
   end

   def has_valid_md5?
      output = rpm.exec(
        line: " -K #{rpm.no_signature_key} :file",
        file: file)

      output && !(output.strip.split(': ').last.force_encoding('utf-8') !~ rpm.valid_signature_answer)
   end

   def source?
      arch == 'src'
   end

   def filename
      @filename ||= "#{name}-#{version}-#{release}.#{arch}.rpm"
   end

   private

   def read key
      tag = key.is_a?(Symbol) && "%{#{key}}" || key

      output = rpm.exec(
        line: '-qp --queryformat=:tag :file',
        tag: tag,
        file: file)

      output.split("\uFFFE").first
   rescue ArgumentError
      output.unpack("C*").reject {|x| x > 127 }.pack("C*").force_encoding("UTF-8")
   end

   class << self
      def version
         @@version ||= exec('--version').split(/\s+/).last
      end

      def no_signature_key
         @@no_signature_key ||= exec('--nosignature').present? && '--nosignature' || '--nogpg'
      end

      def use_common_signature?
         no_signature_key == '--nosignature'
      end

      def valid_signature_answer
         use_common_signature? && /sha1 md5 O[KК]/ || /md5 O[KК]/
      end

      def hash_of args
         if args.is_a?(String)
            { line: args }
         elsif args.is_a?(Hash)
            args
         else
            raise
         end
      end

      def exec args
         a_hash = hash_of(args)

         wrapper = Cocaine::CommandLine.new('rpm', a_hash[:line], environment: { 'LANG' => 'C', 'LC_ALL' => 'en_US.UTF-8' })

         result = wrapper.run(a_hash)
         result !~ /\A(\(none\)|)\z/ && result.force_encoding('utf-8') || nil
      rescue Cocaine::CommandNotFoundError
         Rails.logger.info('rpm command not found')

         nil
      rescue Cocaine::ExitStatusError
         Rails.logger.info('rpm exit status non zero')

         nil
      end
   end
end
