class SecurityRssController < ApplicationController
  def index
    @branch = Branch.find_by!(name: params[:branch])
    @changelogs = @branch.changelogs.where("changelogs.changelogtext LIKE '%CVE%'").includes(:srpm).includes(srpm: [:branch]).order('changelogs.changelogtime DESC').page(1).per(50)
    render layout: nil
    response.headers['Content-Type'] = 'application/xml; charset=utf-8'
  end
end
