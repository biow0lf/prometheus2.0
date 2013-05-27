class SourcesController < ApplicationController
  def index
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @srpm = @branch.srpms.where(name: params[:srpm_id]).includes(:sources).first
    render status: 404, action: '404' and return if @srpm == nil
    @allsrpms = Srpm.where(name: params[:srpm_id]).includes(:branch).order('branches.order_id')
  end

  def download
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @srpm = @branch.srpms.where(name: params[:srpm_id]).first
    render status: 404, action: '404' and return if @srpm == nil
    @source = @srpm.sources.where(filename: params[:id]).first
    render status: 404, action: '404' and return if @source == nil
    if @source && @source.source?
      send_data @source.source, disposition: 'attachment', filename: @source.filename
    elsif @source && !@source.source?
      render layout: false
    end
  end
end
