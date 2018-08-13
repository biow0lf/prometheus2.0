class BranchPathsToBranchesSerializer < ActiveModel::Serializer::CollectionSerializer
   def as_json *args
      serializable_hash
   end

   def serializable_hash adapter_options = {},
                         options = {},
                         adapter_instance = ActiveModel::Serializer.serialization_adapter_instance.new(self)

      include_directive = ActiveModel::Serializer.include_directive_from_options(adapter_options)
      adapter_options[:cached_attributes] ||= ActiveModel::Serializer.cache_read_multi(self, adapter_instance, include_directive)
      adapter_opts = adapter_options.merge(include_directive: include_directive)

      object.reduce({}) do |sum, branch_path|
         next sum if branch_path.empty?

         branch_s = BranchSerializer.new(branch_path.branch).serializable_hash(adapter_opts, options, adapter_instance)
         branch_path_s = BranchPathSerializer.new(branch_path).serializable_hash(adapter_opts, options, adapter_instance)

         if sum[branch_s]
            sum[branch_s] << branch_path_s
         else
            sum[branch_s] = [ branch_path_s ]
         end

         sum
      end
   end
end
