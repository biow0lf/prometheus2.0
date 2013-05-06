class RssController < ApplicationController
  def index
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @srpms = @branch.srpms.where("srpms.created_at > ?", Time.now - 2.day).includes(:group).order('srpms.created_at DESC').all
    render layout: nil
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end
end
