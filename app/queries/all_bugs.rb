class AllBugs < Rectify::Query
  attr_reader :components

  def initialize(components)
    @components = components
  end

  def query
    Bug.where(component: components)
  end
end
