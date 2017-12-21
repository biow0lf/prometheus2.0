# frozen_string_literal: true

class SourcesController < ApplicationController
  def index
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.find_by!(name: params[:srpm_id])
    @sources = Source.where(srpm: @srpm).select('filename, size, source')
    @allsrpms = AllSrpmsWithName.new(params[:srpm_id]).search.decorate
    @all_bugs = AllBugsForSrpm.new(@srpm).decorate
    @opened_bugs = OpenedBugsForSrpm.new(@srpm).decorate
  end
end
