class PackagesAsArchedPackagesSerializer < ActiveModel::Serializer::CollectionSerializer
   def as_json *args
      serializable_hash
   end

   def serializable_hash adapter_options = {},
                         options = {},
                         adapter_instance = ActiveModel::Serializer.serialization_adapter_instance.new(self)

      include_directive = ActiveModel::Serializer.include_directive_from_options(adapter_options)
      adapter_options[:cached_attributes] ||= ActiveModel::Serializer.cache_read_multi(self, adapter_instance, include_directive)
      adapter_opts = adapter_options.merge(include_directive: include_directive)

      opts = options.merge(self.instance_variable_get(:@options) || {})
      object.reduce({}) do |sum, package|
         arch = package.arch
         package_s = PackageSerializer.new(package).serializable_hash(adapter_opts, opts, adapter_instance)

         next sum if !package_s[:href]

         if sum[arch]
            sum[arch] << package_s
         else
            sum[arch] = [ package_s ]
         end

         sum
      end
   end
end
