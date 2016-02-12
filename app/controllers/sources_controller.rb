class SourcesController < ApplicationController
  def index
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:srpm_id]).includes(:sources).first!
    @allsrpms = Srpm.where(name: params[:srpm_id]).includes(:branch).order('branches.order_id').decorate
  end
end
