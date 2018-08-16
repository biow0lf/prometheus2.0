# frozen_string_literal: true

class SourceDownloadController < ApplicationController
  def show
    @srpm = @branch.srpms.find_by!(name: params[:srpm_id])
    @source = @srpm.sources.find_by!(filename: params[:source_id])
    if @source.content?
      send_data @source.content, disposition: 'attachment', filename: @source.filename
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end
