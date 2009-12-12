# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotifiable

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
#  before_filter :set_loc, :set_search
  before_filter :set_search
  before_init_gettext :default_locale

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  init_gettext "prometheus"

  def default_locale
    params[:locale] ||= 'en'
    I18n.locale = params[:locale]
    set_locale params[:locale]
  end

  def set_search
    params[:search] = params[:request] if params[:search].nil?
  end

end
