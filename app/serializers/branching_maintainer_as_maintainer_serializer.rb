class BranchingMaintainerAsMaintainerSerializer < RecordSerializer
   attributes :name, :srpms_count, :login

   def name
      object.maintainer.name
   end

   def login
      object.maintainer.login
   end
end
