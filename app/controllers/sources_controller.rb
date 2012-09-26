# encoding: utf-8

class SourcesController < ApplicationController
  def index
  	@branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
  	@srpm = @branch.srpms.where(name: params[:srpm_id]).includes(:sources).first
  	if @srpm
  	  @allsrpms = Srpm.where(name: params[:srpm_id]).includes(:branch).order('branches.order_id')
  	end
  end

  def show
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
  end

  def get
  end
end
