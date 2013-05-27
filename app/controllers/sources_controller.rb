class SourcesController < ApplicationController
  def index
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:srpm_id]).includes(:sources).first!
    @allsrpms = Srpm.where(name: params[:srpm_id]).includes(:branch).order('branches.order_id')
  end

  def download
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:srpm_id]).first!
    @source = @srpm.sources.where(filename: params[:id]).first
    if @source && @source.source?
      send_data @source.source, disposition: 'attachment', filename: @source.filename
    elsif @source && !@source.source?
      render layout: false
    end
  end
end
