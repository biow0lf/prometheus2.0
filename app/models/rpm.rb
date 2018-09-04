# frozen_string_literal: true

class Rpm < ApplicationRecord
   belongs_to :branch_path, inverse_of: :rpms, counter_cache: :srpms_count
   belongs_to :package, autosave: true

   has_one :branch, through: :branch_path
   has_one :builder, through: :package, class_name: 'Maintainer'

   default_scope -> { where(obsoleted_at: nil) }

   scope :by_branch_path, ->(id) { where(branch_path_id: id) }
   scope :by_name, ->(name) { where(name: name) }
   scope :names, -> { select(:name).distinct }
   scope :src, -> { joins(:package).where(packages: { arch: 'src' })}

   delegate :arch, to: :package

   before_create   :increment_branch_path_counter
   before_destroy  :decrement_branch_path_counter

   after_create    :update_branching_maintainer_counter

   after_destroy   :update_branching_maintainer_counter
   after_destroy   :remove_acls_from_cache
   after_destroy   :remove_leader_from_cache

   validates_presence_of :branch_path, :filename

   before_save :fill_name_in, on: :create

   protected

   def update_branching_maintainer_counter
      srpms_count = builder.srpm_names.joins(:branch_path).where(branch_paths: { branch_id: branch }).count
      BranchingMaintainer.where(maintainer_id: builder, branch_id: branch).update_all(srpms_count: srpms_count)
   end

   def decrement_branch_path_counter
      BranchPath.decrement_counter(:srpms_count, branch_path.id)
   end

   def increment_branch_path_counter
      BranchPath.increment_counter(:srpms_count, branch_path.id)
   end

   def remove_acls_from_cache
      Redis.current.del("#{ branch.name }:#{ filename }:acls")
   end

   def remove_leader_from_cache
      Redis.current.del("#{ branch.name }:#{ filename }:leader")
   end

   def fill_name_in
      self.name ||= filename.split(/-/)[0...-2].join('-')
   end
end
