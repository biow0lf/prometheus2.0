# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    Rails.logger.debug "III"
    @branch = Branch.find_by!(name: params[:branch])
    logger.debug "1"
    @branches = Branch.order('order_id')
    logger.debug "2"
    @top15 = Maintainer.top15(@branch)
    logger.debug "3"
    @srpms = @branch.srpms.where("srpms.created_at > '2010-11-09 09:00:00'").includes(:builder).order('srpms.created_at DESC').page(params[:page]).per(40).decorate
  rescue
    logger.debug "E"
    logger.debug "#{$!}"
  end
end
