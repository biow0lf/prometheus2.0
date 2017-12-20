# frozen_string_literal: true

class OpenedBugsForSrpm < Rectify::Query
  BUG_STATUSES = ['NEW', 'ASSIGNED', 'VERIFIED', 'REOPENED'].freeze

  attr_reader :scope

  def initialize(srpm)
    @scope = AllBugsForSrpm.new(srpm)
  end

  def query
    scope.query.where(bug_status: BUG_STATUSES).order(bug_id: :desc)
  end

  def decorate
    query.decorate
  end
end
