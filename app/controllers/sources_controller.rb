# frozen_string_literal: true

class SourcesController < ApplicationController
  before_action :fetch_srpms_by_name, only: %i(index)

  def index
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.find_by!(name: params[:srpm_id])
    @sources = Source.where(srpm: @srpm).select('filename, size, source')
    @all_bugs = AllBugsForSrpm.new(@srpm).decorate
    @opened_bugs = OpenedBugsForSrpm.new(@srpm).decorate
  end

  protected

  def fetch_srpms_by_name
    @srpms_by_name = SrpmBranchesSerializer.new(NamedSrpm.by_srpm_name(params[:srpm_id]).includes(:branch_path, :srpm, :branch).order('branches.order_id'))
  end
end
