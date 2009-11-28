# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotifiable

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :set_loc, :set_search

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  init_gettext "prometheus"

  def set_loc
    params[:locale] ||= 'en'
    I18n.locale = params[:locale]
#    I18n.locale = params[:locale]
#    params[:locale] = 'en' if params[:locale].nil?
    set_locale params[:locale]
  end

  def set_search
    params[:search] = params[:request] if params[:search].nil?
  end

end
