class OpenedBugsForMaintainer < Rectify::Query
  BUG_STATUSES = %w(NEW ASSIGNED VERIFIED REOPENED).freeze

  attr_reader :scope

  def initialize(branch, maintainer)
    @scope = AllBugsForMaintainer.new(branch, maintainer)
  end

  def query
    scope.query.where(bug_status: BUG_STATUSES).order(bug_id: :desc)
  end

  def decorate
    query.decorate
  end
end
