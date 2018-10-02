# frozen_string_literal: true

class SecurityRssController < ApplicationController
  def index
    @changelogs = @branch.changelogs.where("changelogs.changelogtext LIKE '%CVE%'").includes(:packages).includes(packages: [:branches]).order('changelogs.changelogtime DESC').page(1).per(50)
    render layout: nil
    response.headers['Content-Type'] = 'application/xml; charset=utf-8'
  end
end
