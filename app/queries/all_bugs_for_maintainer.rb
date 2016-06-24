class AllBugsForMaintainer < Rectify::Query
  attr_reader :branch, :maintainer

  def initialize(branch, maintainer)
    @branch = branch
    @maintainer = maintainer
  end

  def query
    Bug.where('component IN (?) OR assigned_to = ?', components, maintainer.email).order(bug_id: :desc)
  end

  def decorate
    query.decorate
  end

  private

  def components
    branch.srpms.includes(:packages).where(name: Redis.current.smembers("#{ branch.name }:maintainers:#{ maintainer.login }")).pluck('packages.name').sort.uniq
  end
end
