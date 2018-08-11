class BranchPathSerializer < RecordSerializer
   attributes :name, :count

   def count
      object.srpms_count
   end
end
