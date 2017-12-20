# frozen_string_literal: true

class PatchDownloadController < ApplicationController
  def show
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.find_by!(name: params[:srpm_id])
    @patch = @srpm.patches.find_by!(filename: params[:patch_id])
    if @patch.patch?
      send_data @patch.patch, disposition: 'attachment', filename: @patch.filename
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end
