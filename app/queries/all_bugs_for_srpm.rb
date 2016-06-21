class AllBugsForSrpm < Rectify::Query
  attr_reader :srpm

  def initialize(srpm)
    @srpm = srpm
  end

  def query
    Bug.where(component: components).order(bug_id: :desc)
  end

  private

  def components
    @components ||= srpm.packages.pluck(:name).flatten.sort.uniq
  end
end
