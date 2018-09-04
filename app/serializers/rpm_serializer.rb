class RpmSerializer < RecordSerializer
   attributes :pure_name, :evr, :path_name

   def path_name
      object.branch_path.name
   end

   def pure_name
      object.name
   end

   def evr
      if object.package.epoch
         "#{object.package.epoch}:#{object.package.version}-#{object.package.release}"
      else
         "#{object.package.version}-#{object.package.release}"
      end
   end
end
