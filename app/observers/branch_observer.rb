class BranchObserver < ActiveRecord::Observer
  def after_create(branch)
    branch.counter.value = 0
  end

  def after_destroy(branch)
    Redis.current.del("branch:#{ branch.id }:counter")
  end
end
