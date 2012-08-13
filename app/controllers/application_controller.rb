# encoding: utf-8

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :set_default_locale
  before_filter :set_default_branch

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def set_default_locale
    params[:locale] ||= 'en'
    I18n.locale = params[:locale].to_sym
    FastGettext.locale = params[:locale].to_sym
  end

  def set_default_branch
    params[:branch] ||= 'Sisyphus'
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
  end

  def default_url_options(options = {})
    { locale: I18n.locale }
  end

#  def load_branch
#    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
#    if @branch == nil
#      render status: 404 and return
#    end
#  end
end
