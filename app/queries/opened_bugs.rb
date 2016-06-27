# TODO: remove this
class OpenedBugs < Rectify::Query
  BUG_STATUSES = %w(NEW ASSIGNED VERIFIED REOPENED).freeze

  attr_reader :scope

  def initialize(components)
    @scope = AllBugs.new(components)
  end

  def query
    scope.query.where(bug_status: BUG_STATUSES).order(bug_id: :desc)
  end
end
