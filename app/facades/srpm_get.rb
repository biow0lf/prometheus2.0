class SrpmGet
  attr_reader :branch, :srpm, :allsrpms, :mirrors, :i586, :noarch, :x86_64,
              :arm

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

  def allsrpms
    @allsrpms ||= Srpm.where(name: @srpm_name).
                       includes(:branch).
                       order('branches.order_id')
  end

  def mirrors
    @mirrors ||= Mirror.where(branch: branch).
                        where("protocol != 'rsync'").
                        order('mirrors.order_id ASC')
  end

  def i586
    @i586 ||= srpm.packages.where(arch: 'i586').order('packages.name ASC')
  end

  def noarch
    @noarch ||= srpm.packages.where(arch: 'noarch').order('packages.name ASC')
  end

  def x86_64
    @x86_64 ||= srpm.packages.where(arch: 'x86_64').order('packages.name ASC')
  end

  def arm
    @arm ||= srpm.packages.where(arch: 'arm').order('packages.name ASC')
  end
end
