class SrpmShow
  attr_reader :branch, :srpm, :allsrpms, :ftbfs, :leader, :maintainers, :teams,
              :perl_watch

  def initialize(branch_name, srpm_name)
    @srpm_name   = srpm_name
    @branch_name = branch_name
  end

  def branch
    @branch ||= Branch.where(name: @branch_name, vendor: 'ALT Linux').first
  end

  def srpm
    @srpm ||= branch.srpms.where(name: @srpm_name).first
    @srpm.decorate if @srpm
  end

  def allsrpms
    @allsrpms ||= Srpm.where(name: @srpm_name).
                       includes(:branch).
                       order('branches.order_id').decorate
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

  def perl_watch
    if srpm.name[0..4] == 'perl-' && srpm.name != 'perl'
      @perl_watch ||= PerlWatch.where(name: srpm.name[5..-1].gsub('-', '::')).first
    end
  end
end
