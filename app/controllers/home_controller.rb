class HomeController < ApplicationController
  def index
    @branch = Branch.where(name: params[:branch]).first
    @branches = Branch.order('order_id')
    @top15 = Maintainer.top15(@branch)
    @srpms = @branch.srpms.where("srpms.created_at > '2010-11-09 09:00:00'").includes(:branch, :builder).order('srpms.created_at DESC').page(params[:page]).per(50)
  end
end
