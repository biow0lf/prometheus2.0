class SrpmShow
  attr_reader :branch, :srpm, :allsrpms, :ftbfs, :leader, :maintainers, :teams

  def initialize(branch_name, srpm_name)
    @srpm_name   = srpm_name
    @branch_name = branch_name
  end

  def branch
    @branch ||= Branch.where(name: @branch_name, vendor: 'ALT Linux').first
  end

  def srpm
    @srpm ||= branch.srpms.where(name: @srpm_name).first
  end

  def allsrpms
    @allsrpms ||= Srpm.where(name: @srpm_name).includes(:branch).order('branches.order_id')
  end

  def ftbfs
    @ftbfs ||= branch.ftbfs.where(name: @srpm.name,
                                  version: @srpm.version,
                                  release: @srpm.release,
                                  epoch: @srpm.epoch).
                            select('DISTINCT id, arch, weeks')
  end

  def leader
    if srpm.leader_is_team?
      @leader = MaintainerTeam.where(login: srpm.leader.value).first
    else
      @leader = Maintainer.where(login: srpm.leader.value).first
    end
  end

  def maintainers
    @maintainers ||= Maintainer.where(login: srpm.maintainers).order(:name)
  end

  def teams
    @teams ||= MaintainerTeam.where(login: srpm.teams).order(:name)
  end
end
