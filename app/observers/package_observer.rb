class PackageObserver < ActiveRecord::Observer
  def after_destroy(package)
    Redis.current.del("#{ package.srpm.branch.name }:#{ package.filename }")
  end
end
