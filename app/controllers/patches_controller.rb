class PatchesController < ApplicationController
  def index
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @srpm = @branch.srpms.where(name: params[:srpm_id]).includes(:patches).first
    render status: 404, action: '404' and return if @srpm == nil
    @allsrpms = Srpm.where(name: params[:srpm_id]).includes(:branch).order('branches.order_id')
  end

  def download
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @srpm = @branch.srpms.where(name: params[:srpm_id]).first
    render status: 404, action: '404' and return if @srpm == nil
    @patch = @srpm.patches.where(filename: params[:id]).first
    render status: 404, action: '404' and return if @patch == nil
    if @patch && @patch.patch?
      send_data @patch.patch, disposition: 'attachment', filename: @patch.filename
    elsif @patch && !@patch.patch?
      render layout: false
    end
  end

  def show
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @srpm = @branch.srpms.where(name: params[:srpm_id]).first
    render status: 404, action: '404' and return if @srpm == nil
    @patch = @srpm.patches.where(filename: params[:id]).first
    @html_data = CodeRay.scan(@patch.patch, :diff).div(:line_numbers => :table)
  end
end
