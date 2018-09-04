# frozen_string_literal: true

class SourcesController < ApplicationController
  before_action :set_version
  before_action :fetch_spkg
  before_action :fetch_spkgs_by_name, only: %i(index)

  def index
    @sources = Source.where(package: @srpm).select('filename, size, source')
    @all_bugs = AllBugsForSrpm.new(@srpm).decorate
    @opened_bugs = OpenedBugsForSrpm.new(@srpm).decorate
  end

  protected

  def fetch_spkg
    @srpm = @branch.spkgs.by_name(params[:srpm_id]).by_evr(params[:version]).first!
  end

  def fetch_spkgs_by_name
    @srpms_by_name = SrpmBranchesSerializer.new(Rpm.by_name(params[:srpm_id]).includes(:branch_path, :package, :branch).order('branches.order_id'))
  end

  def set_version
    @version = params[:version]
  end
end
