class BranchObserver < ActiveRecord::Observer
  def after_create(branch)
    branch.counter.value = 0
  end
end
