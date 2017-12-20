# frozen_string_literal: true

class AllSrpmsWithName < Rectify::Query
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def query
    Srpm.where(name: name).includes(:branch).order('branches.order_id')
  end

  def decorate
    query.decorate
  end
end
