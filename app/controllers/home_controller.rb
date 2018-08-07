# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @branch = (Branch.find_by(name: params[:branch] || 'Sisyphus') || Branch.new).decorate
    @branches = Branch.order('order_id')
    @branch_paths = BranchPath.for_branch(@branches).unanonimous.source
    @top15 = Maintainer.top15(@branch)
    @srpms = @branch.srpms.includes(:builder).ordered.page(params[:page]).per(40).decorate
  end
end
