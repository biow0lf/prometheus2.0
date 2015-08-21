class SourcesController < ApplicationController
  def index
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:srpm_id]).includes(:sources).first!
    @allsrpms = Srpm.where(name: params[:srpm_id]).includes(:branch).order('branches.order_id').decorate
  end

  def download
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.find_by!(name: params[:srpm_id])
    @source = @srpm.sources.find_by!(filename: params[:id])
    if @source && @source.source?
      send_data @source.source, disposition: 'attachment', filename: @source.filename
    elsif @source && !@source.source?
      render layout: false
    end
  end
end
