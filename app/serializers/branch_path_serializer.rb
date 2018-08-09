class BranchPathSerializer < RecordSerializer
   attributes :name, :count

   def count
      object.named_srpms.count(:all)
   end
end
