# encoding: utf-8

class SrpmsController < ApplicationController
  def show
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).includes(:packages, :group, :branch).first!

    @ftbfs = @branch.ftbfs.where(name: @srpm.name,
                                 version: @srpm.version,
                                 release: @srpm.release,
                                 epoch: @srpm.epoch).select('DISTINCT id, arch, weeks').all
    @contributors = Srpm.contributors(@branch, @srpm)
    if @srpm.name[0..4] == 'perl-' && @srpm.name != 'perl'
      @perl_watch = PerlWatch.where(name: @srpm.name[5..-1].gsub('-', '::')).first
    end
    @allsrpms = Srpm.where(name: params[:id]).includes(:branch).order('branches.order_id')
    if $redis.exists("#{@branch.name}:#{@srpm.name}:acls")
      @maintainers = Maintainer.where(login: $redis.smembers("#{@branch.name}:#{@srpm.name}:acls").reject{|acl| acl[0] == '@'}).order(:name)
      @teams = MaintainerTeam.where(login: $redis.smembers("#{@branch.name}:#{@srpm.name}:acls").reject{|acl| acl[0] != '@'}).order(:name)
    end
    if $redis.exists("#{@branch.name}:#{@srpm.name}:leader")
      login = $redis.get("#{@branch.name}:#{@srpm.name}:leader")
      if login[0] == '@'
        @leader = MaintainerTeam.where(login: login).first
      else
        @leader = Maintainer.where(login: login).first
      end
    end
  end

  def changelog
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first!
    @changelogs = @srpm.changelogs.order('changelogs.created_at ASC')
    @allsrpms = Srpm.where(name: params[:id]).includes(:branch).order('branches.order_id')
  end

  def spec
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first!
    @allsrpms = Srpm.where(name: params[:id]).includes(:branch).order('branches.order_id')
  end

  def rawspec
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
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
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @mirrors = Mirror.where(branch_id: @branch).where{protocol != 'rsync'}.order('mirrors.order_id ASC')
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first!

    @allsrpms = Srpm.where(name: params[:id]).includes(:branch).order('branches.order_id')
    @i586 = @srpm.packages.where(arch: 'i586').order('packages.name ASC')
    @noarch = @srpm.packages.where(arch: 'noarch').order('packages.name ASC')
    @x86_64 = @srpm.packages.where(arch: 'x86_64').order('packages.name ASC')
    @arm = @srpm.packages.where(arch: 'arm').order('packages.name ASC')
  end

  def gear
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first!

    # TODO: use srpm_id !
    @gears = Gear.where(repo: params[:id]).includes(:maintainer).order('lastchange DESC')
  end

  def bugs
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first!

    names = @srpm.packages.map { |package| package.name }.flatten.sort.uniq

    @bugs = Bug.where(component: names, bug_status: ['NEW', 'ASSIGNED', 'VERIFIED', 'REOPENED']).order('bug_id DESC')
    @allbugs = Bug.where(component: names).order('bug_id DESC')
  end

  def allbugs
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first!

    names = @srpm.packages.map { |package| package.name }.flatten.sort.uniq

    @bugs = Bug.where(component: names, bug_status: ['NEW', 'ASSIGNED', 'VERIFIED', 'REOPENED']).order('bug_id DESC')
    @allbugs = Bug.where(component: names).order('bug_id DESC')
  end

  def repocop
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first!
    @repocops = Repocop.where(srcname: @srpm.name,
                              srcversion: @srpm.version,
                              srcrel: @srpm.release)
  end
end
