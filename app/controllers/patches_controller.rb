class PatchesController < ApplicationController
  def index
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = Srpm.find_by!(branch_id: @branch.id, name: params[:srpm_id]).includes(:patches)
    @allsrpms = Srpm.where(name: params[:srpm_id]).includes(:branch).order('branches.order_id')
  end

  def download
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = Srpm.find_by!(branch_id: @branch.id, name: params[:srpm_id])
    @patch = Patch.find_by!(srpm_id: @srpm.id, filename: params[:id])
    if @patch && @patch.patch?
      send_data @patch.patch, disposition: 'attachment', filename: @patch.filename
    elsif @patch && !@patch.patch?
      render layout: false
    end
  end

  def show
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = Srpm.find_by!(branch_id: @branch.id, name: params[:srpm_id])
    @patch = Patch.find_by!(srpm_id: @srpm.id, filename: params[:id])
    @html_data = CodeRay.scan(@patch.patch, :diff).div(line_numbers: :table)
  end
end
