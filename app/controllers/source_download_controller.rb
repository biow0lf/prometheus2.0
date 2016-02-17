class SourceDownloadController < ApplicationController
  def show
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.find_by!(name: params[:srpm_id])
    @source = @srpm.sources.find_by!(filename: params[:source_id])
    if @source.source?
      send_data @source.source, disposition: 'attachment', filename: @source.filename
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end
