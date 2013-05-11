class Api::V1::SrpmsController < ApplicationController
  def srpms_list
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpms = @branch.srpms.order(:name).select(:name)
  end

  def show
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).first
  end

  def changelog
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).first
    @changelogs = @srpm.changelogs.order('changelogs.created_at ASC')
  end

  def gear
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).first
    @gears = Gear.where(repo: params[:id]).order('lastchange DESC')
  end

  def bugs
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).first
    names = @srpm.packages.map { |package| package.name }.flatten.sort.uniq
    @bugs = Bug.where(component: names, bug_status: ['NEW', 'ASSIGNED', 'VERIFIED', 'REOPENED']).order('bug_id DESC')
  end

  def allbugs
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).first
    names = @srpm.packages.map { |package| package.name }.flatten.sort.uniq
    @allbugs = Bug.where(component: names).order('bug_id DESC')
  end

  def repocop
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).first
    @repocops = Repocop.where(srcname: @srpm.name,
                              srcversion: @srpm.version,
                              srcrel: @srpm.release)
  end
end
