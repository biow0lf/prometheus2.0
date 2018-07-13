# frozen_string_literal: true

class PackagesDecorator < Draper::CollectionDecorator
   def arched_packages
      self.group_by { |x| x.arch }
   end
end
