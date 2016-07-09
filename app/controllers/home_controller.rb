class HomeController < ApplicationController
  def index
    @branch = Branch.find_by!(name: params[:branch])
    @branches = Branch.order('order_id')
    @top15 = Maintainer.top15(@branch)
    @srpms = @branch.srpms.where("srpms.created_at > '2010-11-09 09:00:00'").includes(:builder).order('srpms.created_at DESC').page(params[:page]).per(40).decorate
  end
end
