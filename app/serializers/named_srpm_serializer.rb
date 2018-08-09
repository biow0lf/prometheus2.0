class NamedSrpmSerializer < RecordSerializer
   attributes :pure_name, :evr, :path_name

   def path_name
      object.branch_path.name
   end

   def pure_name
      object.srpm.name
   end

   def evr
      if object.srpm.epoch
         "#{object.srpm.epoch}:#{objectsrpm.srpm.version}-#{object.srpm.elease}"
      else
         "#{object.srpm.version}-#{object.srpm.release}"
      end
   end
end
