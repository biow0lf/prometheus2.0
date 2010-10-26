# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotifiable

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :set_search
  before_filter :default_locale

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def default_locale
    params[:locale] ||= 'en'
    I18n.locale = params[:locale]
    FastGettext.locale = params[:locale]
  end

  def set_search
    params[:search] = params[:request] if params[:search].nil?
  end

  def default_url_options(options={})
    { :locale => params[:locale] }
  end
end