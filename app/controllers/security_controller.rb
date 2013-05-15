class SecurityController < ApplicationController
  def index
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @changelogs = @branch.changelogs.where("changelogs.changelogtext LIKE '%CVE%'").order('changelogs.changelogtime DESC').page(params[:page]).per(50)
  end
end
