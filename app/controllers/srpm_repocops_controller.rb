class SrpmRepocopsController < ApplicationController
  def index
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.find_by!(name: params[:id])
    @all_bugs = AllBugsForSrpm.new(@srpm).decorate
    @opened_bugs = OpenedBugsForSrpm.new(@srpm).decorate
    @repocops = @srpm.repocops.page(params[:page]).per(1_000)
  end
end
