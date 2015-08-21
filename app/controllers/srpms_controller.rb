class SrpmsController < ApplicationController
  def show
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:id]).includes(:packages, :branch).first!.decorate
    @ftbfs = @branch.ftbfs.where(name: @srpm.name,
                                 version: @srpm.version,
                                 release: @srpm.release,
                                 epoch: @srpm.epoch.to_s).select('DISTINCT id, arch, weeks')
    if @srpm.name[0..4] == 'perl-' && @srpm.name != 'perl'
      @perl_watch = PerlWatch.where(name: @srpm.name[5..-1].gsub('-', '::')).first
    end
    @allsrpms = Srpm.where(name: params[:id]).includes(:branch).order('branches.order_id').decorate
    if Redis.current.exists("#{@branch.name}:#{@srpm.name}:acls")
      @maintainers = Maintainer.where(login: Redis.current.smembers("#{@branch.name}:#{@srpm.name}:acls").reject{|acl| acl[0] == '@'}).order(:name)
      @teams = MaintainerTeam.where(login: Redis.current.smembers("#{@branch.name}:#{@srpm.name}:acls").reject{|acl| acl[0] != '@'}).order(:name)
    end
    if Redis.current.exists("#{@branch.name}:#{@srpm.name}:leader")
      login = Redis.current.get("#{@branch.name}:#{@srpm.name}:leader")
      if login[0] == '@'
        @leader = MaintainerTeam.where(login: login).first
      else
        @leader = Maintainer.where(login: login).first
      end
    end
  end

  def changelog
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:id]).includes(:branch).first!
    @changelogs = @srpm.changelogs.order('changelogs.created_at ASC')
    @allsrpms = Srpm.where(name: params[:id]).includes(:branch).order('branches.order_id').decorate
  end

  def spec
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:id]).includes(:branch).first!
    @allsrpms = Srpm.where(name: params[:id]).includes(:branch).order('branches.order_id').decorate
  end

  def rawspec
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first!
    if @srpm.specfile
      send_data @srpm.specfile.spec, disposition: 'attachment', type: 'text/plain', filename: "#{@srpm.name}.spec"
    else @srpm.specfile.nil?
      render layout: false
    end
  end

  def get
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:id]).includes(:branch).first!
    @mirrors = Mirror.where(branch_id: @branch).where("protocol != 'rsync'").order('mirrors.order_id ASC')
    @allsrpms = Srpm.where(name: params[:id]).includes(:branch).order('branches.order_id').decorate
    @i586 = @srpm.packages.where(arch: 'i586').order('packages.name ASC')
    @noarch = @srpm.packages.where(arch: 'noarch').order('packages.name ASC')
    @x86_64 = @srpm.packages.where(arch: 'x86_64').order('packages.name ASC')
    @arm = @srpm.packages.where(arch: 'arm').order('packages.name ASC')
  end

  def gear
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:id]).includes(:branch).first!
    # TODO: use srpm_id !
    @gears = Gear.where(repo: params[:id]).includes(:maintainer).order('lastchange DESC')
  end

  def bugs
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:id]).includes(:branch).first!

    names = @srpm.packages.map { |package| package.name }.flatten.sort.uniq

    @bugs = Bug.opened_bugs_for(names)
    @allbugs = Bug.all_bugs_for(names)
  end

  def allbugs
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:id]).includes(:branch).first!

    names = @srpm.packages.map { |package| package.name }.flatten.sort.uniq

    @bugs = Bug.opened_bugs_for(names)
    @allbugs = Bug.all_bugs_for(names)
  end

  def repocop
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:id]).includes(:branch).first!
    @repocops = Repocop.where(srcname: @srpm.name,
                              srcversion: @srpm.version,
                              srcrel: @srpm.release)
  end
end
