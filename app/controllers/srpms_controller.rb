# encoding: utf-8

class SrpmsController < ApplicationController
  def show
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @srpm = @branch.srpms.where(name: params[:id]).includes(:packages, :group, :branch, :leader, :maintainer).first
    if @srpm
      @ftbfs = @branch.ftbfs.where(name: @srpm.name,
                                   version: @srpm.version,
                                   release: @srpm.release,
                                   epoch: @srpm.epoch).select('DISTINCT arch, weeks').all
      if @srpm.name[0..4] == 'perl-' && @srpm.name != 'perl'
        @perl_watch = PerlWatch.where(name: @srpm.name[5..-1]).first
      end
      @allsrpms = Srpm.where(name: params[:id]).includes(:branch).order('branches.order_id')
      if $redis.exists("#{@branch.name}:#{@srpm.name}:acls")
        @acls = Maintainer.where(login: $redis.smembers("#{@branch.name}:#{@srpm.name}:acls")).order(:name)
      end
    else
      render status: 404, action: 'nosuchpackage'
    end
  end

  def changelog
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first
    if @srpm
      @changelogs = @srpm.changelogs.order('changelogs.created_at ASC')
      @allsrpms = Srpm.where(name: params[:id]).includes(:branch).order('branches.order_id')
    else
      render status: 404, action: 'nosuchpackage'
    end
  end

  def spec
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first
    if @srpm
      @allsrpms = Srpm.where(name: params[:id]).includes(:branch).order('branches.order_id')
    else
      render status: 404, action: 'nosuchpackage'
    end
  end

  def rawspec
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first
    if @srpm && @srpm.specfile
      send_data @srpm.specfile.spec, disposition: 'attachment', type: 'text/plain', filename: "#{@srpm.name}.spec"
    elsif @srpm && @srpm.specfile == nil
      render layout: false
    else
      render status: 404, action: 'nosuchpackage'
    end
  end

  def get
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @mirrors = Mirror.where(branch_id: @branch).where{protocol != 'rsync'}.order('mirrors.order_id ASC')
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first
    if @srpm
      @allsrpms = Srpm.where(name: params[:id]).includes(:branch).order('branches.order_id')
      @i586 = @srpm.packages.where(arch: 'i586').order('packages.name ASC')
      @noarch = @srpm.packages.where(arch: 'noarch').order('packages.name ASC')
      @x86_64 = @srpm.packages.where(arch: 'x86_64').order('packages.name ASC')
      @arm = @srpm.packages.where(arch: 'arm').order('packages.name ASC')
    else
      render status: 404, action: 'nosuchpackage'
    end
  end

  def gear
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first

    if @srpm
      # TODO: use srpm_id !
      @gears = Gear.where(repo: params[:id]).includes(:maintainer).order('lastchange DESC')
    else
      render status: 404, action: 'nosuchpackage'
    end
  end

  def bugs
    # TODO: search for bugs not only by srpm.name, but and by packages.name
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first

    @bugs = Bug.where(component: params[:id],
                      bug_status: ['NEW', 'ASSIGNED', 'VERIFIED', 'REOPENED']
                      ).order('bug_id DESC')

    @allbugs = Bug.where(component: params[:id]).order("bug_id DESC")
    unless @srpm
      render status: 404, action: 'nosuchpackage'
    end
  end

  def allbugs
    # TODO: search for bugs not only by srpm.name, but and by packages.name
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first

    @bugs = Bug.where(component: params[:id],
                      bug_status: ['NEW', 'ASSIGNED', 'VERIFIED', 'REOPENED']
                      ).order('bug_id DESC')

    @allbugs = Bug.where(component: params[:id]).order('bug_id DESC')
    unless @srpm
      render status: 404, action: 'nosuchpackage'
    end
  end

  def repocop
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first
    if @srpm
      @repocops = Repocop.where(srcname: @srpm.name,
                                srcversion: @srpm.version,
                                srcrel: @srpm.release)
    else
      render status: 404, action: 'nosuchpackage'
    end
  end
end
