# frozen_string_literal: true

class SecurityController < ApplicationController
  def index
    @branch = Branch.find_by!(name: params[:branch])
    @changelogs = @branch.changelogs.where("changelogs.changelogtext LIKE '%CVE%'").includes(:srpm).includes(srpm: [:branch]).order('changelogs.changelogtime DESC').page(params[:page]).per(50)
  end
end
