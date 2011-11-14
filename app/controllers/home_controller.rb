# encoding: utf-8

class HomeController < ApplicationController
  def index
    @branches = Branch.order('order_id').all
    if !fragment_exist? "#{params[:locale]}_top15"
      @top15 = Maintainer.top15
    end
    if !fragment_exist? "#{params[:locale]}_srpms_#{@branch.name}_#{params[:page]}"
      @srpms = @branch.srpms.where("srpms.created_at > '2010-11-09 09:00:00'").includes(:group, :maintainer).order('srpms.created_at DESC').page(params[:page]).per(50)
    end
  end

  def maintainers_list
    @maintainers = Maintainer.find_all_maintainers_in(params[:branch])
    @teams = Maintainer.find_all_teams_in(params[:branch])
  end
end
