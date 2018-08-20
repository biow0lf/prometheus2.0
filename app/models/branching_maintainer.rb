# frozen_string_literal: true

class BranchingMaintainer < ApplicationRecord
   belongs_to :branch
   belongs_to :maintainer

   scope :top, ->(limit, branch) { where(branch_id: branch.id).order('srpms_count DESC').limit(limit) }
end
