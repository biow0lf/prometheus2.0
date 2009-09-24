# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotifiable

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :set_locale, :set_search

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    params[:locale] = 'en' if params[:locale].nil?
    I18n.locale = params[:locale]
  end

  def set_search
    params[:search] = params[:request] if params[:search].nil?
  end

end
