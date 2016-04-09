class SrpmObserver < ActiveRecord::Observer
  def after_create(srpm)
    srpm.branch.counter.increment
  end

  # after_destroy :decrement_branch_counter
  #
  # after_create :add_filename_to_cache
  #
  # after_destroy :remove_filename_from_cache
  #
  # after_destroy :remove_acls_from_cache
  #
  # after_destroy :remove_leader_from_cache

  # def decrement_branch_counter
  #   branch.counter.decrement
  # end
  #
  # def add_filename_to_cache
  #   Redis.current.set("#{ branch.name }:#{ filename }", 1)
  # end
  #
  # def remove_filename_from_cache
  #   Redis.current.del("#{ branch.name }:#{ filename }")
  # end
  #
  # def remove_acls_from_cache
  #   Redis.current.del("#{ branch.name }:#{ name }:acls")
  # end
  #
  # def remove_leader_from_cache
  #   Redis.current.del("#{ branch.name }:#{ name }:leader")
  # end
end
