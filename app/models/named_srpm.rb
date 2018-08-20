# frozen_string_literal: true

class NamedSrpm < ApplicationRecord
  belongs_to :branch_path, counter_cache: :srpms_count
  belongs_to :srpm

  has_one :branch, through: :branch_path
  has_one :builder, through: :srpm

  scope :by_branch_path, ->(id) { where(branch_path: id) }
  scope :by_srpm_name, ->(name) { joins(:srpm).where(srpms: { name: name })}

  scope :names, -> { select(:name).distinct }

  validates_presence_of :branch_path, :filename

  before_save     :fill_name_in
  before_create   :increment_branch_path_counter
  before_destroy  :decrement_branch_path_counter

  after_save      :add_filename_to_cache
  after_create    :increment_branch_counter
  after_create    :update_branching_maintainer_counter

  after_destroy   :update_branching_maintainer_counter
  after_destroy   :decrement_branch_counter
  after_destroy   :remove_filename_from_cache
  after_destroy   :remove_acls_from_cache
  after_destroy   :remove_leader_from_cache

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

  def add_filename_to_cache
    Redis.current.set("#{ branch.name }:#{ filename }", 1)
  end

  def increment_branch_counter
    branch.counter.increment
  end

  def decrement_branch_counter
    branch.counter.decrement
  end

  def remove_filename_from_cache
    Redis.current.del("#{ branch.name }:#{ filename }")
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
