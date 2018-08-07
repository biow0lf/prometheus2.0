# frozen_string_literal: true

class NamedSrpm < ApplicationRecord
  belongs_to :branch_path
  belongs_to :srpm

  has_one :branch, through: :branch_path

  scope :by_branch_path, ->(id) { where(branch_path: id) }

  validates_presence_of :branch_path, :name

  after_save    :add_filename_to_cache
  after_create  :increment_branch_counter

  after_destroy :decrement_branch_counter
  after_destroy :remove_filename_from_cache
  after_destroy :remove_acls_from_cache
  after_destroy :remove_leader_from_cache

  private

  def add_filename_to_cache
    Redis.current.set("#{ branch.name }:#{ name }", 1)
  end

  def increment_branch_counter
    branch.counter.increment
  end

  def decrement_branch_counter
    branch.counter.decrement
  end

  def remove_filename_from_cache
    Redis.current.del("#{ branch.name }:#{ name }")
  end

  def remove_acls_from_cache
    Redis.current.del("#{ branch.name }:#{ name }:acls")
  end

  def remove_leader_from_cache
    Redis.current.del("#{ branch.name }:#{ name }:leader")
  end
end
