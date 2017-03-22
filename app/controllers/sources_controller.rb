class SourcesController < ApplicationController
  def index
    @branch = Branch.find_by!(name: params[:branch])
    # @srpm = @branch.srpms.where(name: params[:srpm_id]).includes(:sources).first!
    @srpm = @branch.srpms.find_by!(name: params[:srpm_id])
    @sources = Source.where(srpm: @srpm).select('filename, size')
    @allsrpms = AllSrpmsWithName.new(params[:srpm_id]).decorate
    @all_bugs = AllBugsForSrpm.new(@srpm).decorate
    @opened_bugs = OpenedBugsForSrpm.new(@srpm).decorate
  end
end
