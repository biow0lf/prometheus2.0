class PackageObserver < ActiveRecord::Observer
  def after_save(package)
    package.srpm.update_attribute(:delta, true)
  end

  def after_create(package)
    Redis.current.set("#{ package.srpm.branch.name }:#{ package.filename }", 1)
  end

  def after_destroy(package)
    Redis.current.del("#{ package.srpm.branch.name }:#{ package.filename }")
  end
end
