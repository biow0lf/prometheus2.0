class HomeController < ApplicationController
  def index
    @branches = Branch.all
    @top15 = Maintainer.top15

    if (params[:page] == 1 || params[:page] == nil) && @branch.name == 'Sisyphus'
      @srpms = Rails.cache.read("home-#{@branch.name}")
      if @srpms.nil?
        @srpms = @branch.srpms.where("srpms.created_at > '2010-11-09 09:00:00'").includes(:group, :maintainer).order('srpms.created_at DESC').paginate(:page => params[:page], :per_page => 50)
        Rails.cache.write("home-#{@branch.name}", @srpms)
      end
    else
      @srpms = @branch.srpms.where("srpms.created_at > '2010-11-09 09:00:00'").includes(:group, :maintainer).order('srpms.created_at DESC').paginate(:page => params[:page], :per_page => 50)
    end
  end

  def maintainers_list
    @maintainers = Maintainer.find_all_maintainers_in(params[:branch])
    @teams = Maintainer.find_all_teams_in(params[:branch])
  end
end
