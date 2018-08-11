class BranchSerializer < RecordSerializer
   attributes :name, :srpm_count

   def srpm_count
      object.srpms_count
   end
end
