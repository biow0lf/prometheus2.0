class PatchesController < ApplicationController
  def index
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:srpm_id]).includes(:patches).first!
    @allsrpms = Srpm.where(name: params[:srpm_id]).includes(:branch).order('branches.order_id').decorate
  end

  def show
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.find_by!(name: params[:srpm_id])
    @patch = @srpm.patches.find_by!(filename: params[:id])
    @html_data = CodeRay.scan(@patch.patch, :diff).div(line_numbers: :table)
  end
end
