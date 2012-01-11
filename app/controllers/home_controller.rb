# encoding: utf-8

class HomeController < ApplicationController
  def index
    @branches = Branch.order('order_id').all
    if !fragment_exist?("#{I18n.locale}_top15")
      @top15 = Maintainer.top15
    end
    if !fragment_exist?("#{I18n.locale}_srpms_#{@branch.name}_#{params[:page]}")
      @srpms = @branch.srpms.where("srpms.created_at > '2010-11-09 09:00:00'").includes(:group, :maintainer).order('srpms.created_at DESC').page(params[:page]).per(50)
    end
  end

  def maintainers_list
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @maintainers = Maintainer.where(team: false).order(:name)
    @teams = Maintainer.where(team: true).order(:name)
  end
end
