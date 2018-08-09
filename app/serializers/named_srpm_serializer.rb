class NamedSrpmSerializer < RecordSerializer
   attributes :name, :evr, :path_name

   def path_name
      object.branch_path.name
   end

   def evr
      if object.srpm.epoch
         "#{object.srpm.epoch}:#{objectsrpm.srpm.version}-#{object.srpm.elease}"
      else
         "#{object.srpm.version}-#{object.srpm.release}"
      end
   end
end
