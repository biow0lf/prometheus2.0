class SrpmBranchesSerializer < ActiveModel::Serializer::CollectionSerializer
   def as_json *args
      serializable_hash
   end

   def serializable_hash adapter_options = {},
                         options = {},
                         adapter_instance = ActiveModel::Serializer.serialization_adapter_instance.new(self)

      include_directive = ActiveModel::Serializer.include_directive_from_options(adapter_options)
      adapter_options[:cached_attributes] ||= ActiveModel::Serializer.cache_read_multi(self, adapter_instance, include_directive)
      adapter_opts = adapter_options.merge(include_directive: include_directive)

      object.reduce({}) do |sum, named_srpm|
         nss = NamedSrpmSerializer.new(named_srpm).serializable_hash(adapter_opts, options, adapter_instance)
         branch_name = named_srpm.branch.name

         if sum[branch_name]
            sum[branch_name] << nss
         else
            sum[branch_name] = [ nss ]
         end

         sum
      end
   end
end
