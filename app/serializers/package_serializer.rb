# frozen_string_literal: true

class PackageSerializer < RecordSerializer
   include ActionView::Helpers::NumberHelper

   attributes :name, :filename, :href, :path, :md5, :human_size

   def href
      path&.sub(/^\/ALTmips/, 'http://ftp.altlinux.org/pub/distributions/ALTLinux/ports/mipsel/Sisyphus/')
          &.sub(/^\/ALT/, 'http://ftp.altlinux.org/pub/distributions/ALTLinux')
          &.sub('Sisyphus-armh', 'Sisyphus')
   end

   def human_size
      number_to_human_size(object.size)
   end

   def path
      if object.branch_paths.first
         File.join(object.branch_paths.first.path, filename)
      end
   end

   def filename
      if instance_options[:branch]
         object.rpms.by_branch_path(branch.branch_paths).first&.filename
      else
         object.rpms.first&.filename
      end
   end
end
