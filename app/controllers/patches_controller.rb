class PatchesController < ApplicationController
  def index
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:srpm_id]).includes(:patches).first!
    @allsrpms = Srpm.where(name: params[:srpm_id]).includes(:branch).order('branches.order_id')
  end

  def download
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:srpm_id]).first!
    @patch = @srpm.patches.where(filename: params[:id]).first
    if @patch && @patch.patch?
      send_data @patch.patch, disposition: 'attachment', filename: @patch.filename
    else @patch && !@patch.patch?
      render layout: false
    end
  end

#  def show
#    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
#    @patch = File.read("pmount-0.9.17-alt-floppy.patch")
#  end
end
