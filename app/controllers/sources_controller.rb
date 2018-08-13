# frozen_string_literal: true

class SourcesController < ApplicationController
  before_action :set_version
  before_action :fetch_branch
  before_action :fetch_srpm
  before_action :fetch_srpms_by_name, only: %i(index)

  def index
    @sources = Source.where(srpm: @srpm).select('filename, size, source')
    @all_bugs = AllBugsForSrpm.new(@srpm).decorate
    @opened_bugs = OpenedBugsForSrpm.new(@srpm).decorate
  end

  protected

  def fetch_branch
    @branch = Branch.find_by!(name: params[:branch])
  end

  def fetch_srpm
    @srpm = @branch.srpms.where(name: params[:srpm_id]).by_evr(params[:version]).first!
  end

  def fetch_srpms_by_name
    @srpms_by_name = SrpmBranchesSerializer.new(NamedSrpm.by_srpm_name(params[:srpm_id]).includes(:branch_path, :srpm, :branch).order('branches.order_id'))
  end

  def set_version
    @version = params[:version]
  end
end
