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

# @allsrpms = Srpm.where(name: params[:id]).includes(:branch).order('branches.order_id').decorate


