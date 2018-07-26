# frozen_string_literal: true

class SrpmRepocopsController < ApplicationController
  def index
    @branch = Branch.find_by!(name: params[:branch] || "Sisyphus")
    @srpm = @branch.srpms.find_by!(name: params[:id])
    @all_bugs = AllBugsForSrpm.new(@srpm).decorate
    @opened_bugs = OpenedBugsForSrpm.new(@srpm).decorate
  end
end
