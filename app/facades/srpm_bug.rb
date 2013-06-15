class SrpmBug
  attr_reader :branch, :srpm, :bugs, :allbugs

  def initialize(branch_name, srpm_name)
    @branch_name = branch_name
    @srpm_name   = srpm_name
  end

  def branch
    @branch ||= Branch.where(name: @branch_name, vendor: 'ALT Linux').first
  end

  def srpm
    @srpm ||= branch.srpms.where(name: @srpm_name).first
  end

  def bugs
    @bugs ||= Bug.where(component: names, bug_status: ['NEW', 'ASSIGNED', 'VERIFIED', 'REOPENED']).order('bug_id DESC')
  end

  def allbugs
    @allbugs ||= Bug.where(component: names).order('bug_id DESC')
  end

  private

  def names
    @names ||= srpm.packages.map { |package| package.name }.flatten.sort.uniq
  end
end
