# frozen_string_literal: true

class SrpmsController < ApplicationController
  before_action :fetch_srpms_by_name, only: %i(show changelog spec get)

  def show
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:id]).includes(:packages).first!.decorate
    @ftbfs = @branch.ftbfs.where(name: @srpm.name,
                                 version: @srpm.version,
                                 release: @srpm.release,
                                 epoch: @srpm.epoch).select('DISTINCT id, arch, weeks')
    @changelogs = @srpm.changelogs.order(created_at: :asc).limit(3)
    if @srpm.name[0..4] == 'perl-' && @srpm.name != 'perl'
      @perl_watch = PerlWatch.where(name: @srpm.name[5..-1].gsub('-', '::')).first
    end
    if Redis.current.exists("#{ @branch.name }:#{ @srpm.name }:acls")
      @maintainers = Maintainer.where(login: Redis.current.smembers("#{ @branch.name }:#{ @srpm.name }:acls").reject { |acl| acl[0] == '@' }).order(:name)
      @teams = MaintainerTeam.where(login: Redis.current.smembers("#{ @branch.name }:#{ @srpm.name }:acls").reject { |acl| acl[0] != '@' }).order(:name)
    end
    if Redis.current.exists("#{ @branch.name }:#{ @srpm.name }:leader")
      login = Redis.current.get("#{ @branch.name }:#{ @srpm.name }:leader")
      if login[0] == '@'
        @leader = MaintainerTeam.where(login: login).first
      else
        @leader = Maintainer.where(login: login).first
      end
    end

    @all_bugs = AllBugsForSrpm.new(@srpm).decorate
    @opened_bugs = OpenedBugsForSrpm.new(@srpm).decorate
  end

  def changelog
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:id]).first!
    @changelogs = @srpm.changelogs.order('changelogs.created_at ASC')
    @all_bugs = AllBugsForSrpm.new(@srpm).decorate
    @opened_bugs = OpenedBugsForSrpm.new(@srpm).decorate
  end

  def spec
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:id]).first!
    @all_bugs = AllBugsForSrpm.new(@srpm).decorate
    @opened_bugs = OpenedBugsForSrpm.new(@srpm).decorate
  end

  def rawspec
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first!
    if @srpm.specfile
      send_data @srpm.specfile.spec, disposition: 'attachment', type: 'text/plain', filename: "#{ @srpm.name }.spec"
    else @srpm.specfile.nil?
      render layout: false
    end
  end

  def get
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:id]).last!
    @mirrors = Mirror.where(branch_id: @branch.id).where("protocol != 'rsync'").order('mirrors.order_id ASC')
    @packages = @srpm.packages.order('packages.name ASC').group("packages.arch, packages.id").includes(:branches).decorate
    @all_bugs = AllBugsForSrpm.new(@srpm).decorate
    @opened_bugs = OpenedBugsForSrpm.new(@srpm).decorate
  end

  def gear
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.includes(gears: :maintainer).find_by!(name: params[:id])
    @all_bugs = AllBugsForSrpm.new(@srpm).decorate
    @opened_bugs = OpenedBugsForSrpm.new(@srpm).decorate
  end

  protected

  def fetch_srpms_by_name
    @srpms_by_name = SrpmBranchesSerializer.new(NamedSrpm.by_srpm_name(params[:id]).includes(:branch_path, :srpm, :branch).order('branches.order_id'))
  end
end
