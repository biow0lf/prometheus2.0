# encoding: utf-8

class SourcesController < ApplicationController
  def index
  	@branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
  	@srpm = @branch.srpms.where(name: params[:srpm_id]).includes(:sources).first
  	if @srpm
  	  @allsrpms = Srpm.where(name: params[:srpm_id]).includes(:branch).order('branches.order_id')
  	end
  end

  def download
  	@branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
  	@srpm = @branch.srpms.where(name: params[:srpm_id]).first
    @source = @srpm.sources.where(filename: params[:id]).first
    if @srpm && @source.source?
      send_data @source.source, disposition: 'attachment', filename: @source.filename
    elsif @srpm && !@source.source?
      render layout: false
    else
      render status: 404, action: 'nosuchfile'
    end
  end
end
