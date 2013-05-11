class Api::V1::SrpmsController < ApplicationController
  def srpms_list
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
#    @srpms = branch.srpms.order(:name). pluck(:name).order
    @srpms = @branch.srpms.order(:name).select(:name)
#    2.0.0p0 :023 > Branch.first.srpms.order(:name).limit(10).select(:name)
  end

  def show
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).first
#    render status: 404 and return if @srpm.nil?
#    render status: 404, action: 'nosuchpackage' and return unless @srpm
#
#    @ftbfs = @branch.ftbfs.where(name: @srpm.name,
#                                 version: @srpm.version,
#                                 release: @srpm.release,
#                                 epoch: @srpm.epoch).select('DISTINCT id, arch, weeks').load
#    if $redis.exists("#{@branch.name}:#{@srpm.name}:acls")
#      @maintainers = Maintainer.where(login: $redis.smembers("#{@branch.name}:#{@srpm.name}:acls").reject{|acl| acl[0] == '@'}).order(:name)
#      @teams = MaintainerTeam.where(login: $redis.smembers("#{@branch.name}:#{@srpm.name}:acls").reject{|acl| acl[0] != '@'}).order(:name)
#    end
#    if $redis.exists("#{@branch.name}:#{@srpm.name}:leader")
#      login = $redis.get("#{@branch.name}:#{@srpm.name}:leader")
#      if login[0] == '@'
#        @leader = MaintainerTeam.where(login: login).first
#      else
#        @leader = Maintainer.where(login: login).first
#      end
#    end
  end

  def changelog
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).first
#    render status: 404, action: 'nosuchpackage' and return unless @srpm
    @changelogs = @srpm.changelogs.order('changelogs.created_at ASC')
  end

  def gear
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).first
#    render status: 404, action: 'nosuchpackage' and return unless @srpm
    # TODO: use srpm_id !
    @gears = Gear.where(repo: params[:id]).includes(:maintainer).order('lastchange DESC')
  end

  def bugs
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).first
#    render status: 404, action: 'nosuchpackage' and return unless @srpm
    names = @srpm.packages.map { |package| package.name }.flatten.sort.uniq
    @bugs = Bug.where(component: names, bug_status: ['NEW', 'ASSIGNED', 'VERIFIED', 'REOPENED']).order('bug_id DESC')
  end

  def allbugs
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first
#    render status: 404, action: 'nosuchpackage' and return unless @srpm
    names = @srpm.packages.map { |package| package.name }.flatten.sort.uniq
    @allbugs = Bug.where(component: names).order('bug_id DESC')
  end

  def repocop
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).first
#    render status: 404, action: 'nosuchpackage' and return unless @srpm
    @repocops = Repocop.where(srcname: @srpm.name,
                              srcversion: @srpm.version,
                              srcrel: @srpm.release)
  end
end
