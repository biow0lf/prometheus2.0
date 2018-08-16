# frozen_string_literal: true

class SrpmRepocopsController < ApplicationController
  before_action :set_version

  def index
    @branch = Branch.find_by!(slug: params[:branch] || "sisyphus")
    @srpm = @branch.srpms.find_by!(name: params[:id])
    @all_bugs = AllBugsForSrpm.new(@srpm).decorate
    @opened_bugs = OpenedBugsForSrpm.new(@srpm).decorate
  end

  protected

  def set_version
    @version = params[:version]
  end
end
