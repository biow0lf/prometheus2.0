# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :default_locale
  before_filter :fix_branch
  before_filter :mailer_set_url_options

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def default_locale
    params[:locale] ||= "en"
    I18n.locale = params[:locale]
    FastGettext.locale = params[:locale]
  end

  def fix_branch
    params[:branch] = "Sisyphus" if params[:branch].nil?
    params[:branch] = "Sisyphus" if params[:branch] == "sisyphus"
  end

  def default_url_options(options={})
    { :locale => params[:locale] }
  end
  
  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
