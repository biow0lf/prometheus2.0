# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :redirect_to_localized
  before_action :set_default_locale
  before_action :set_default_branch
  before_action :authorizer_for_profiler
  before_action :authorizer_for_scout_server_timing_profiler

  helper_method :sort_column, :sort_order, :sort_order_next

  helper_method :change_current_page_lang

  def set_default_locale
    params[:locale] ||= 'en'
    I18n.locale = FastGettext.locale = params[:locale]
  end

  def redirect_to_localized
    locale = prefered_locale

    redirect_to(change_current_page_lang(request.fullpath, locale)) if request.fullpath == '/' && locale
  end

  def set_default_branch
    params[:branch] ||= 'Sisyphus'
    @branch = Branch.find_by!(name: params[:branch])
  end

  def default_url_options(_options = {})
    { locale: I18n.locale }
  end

  def sort_column
    ['status', 'name', 'age'].include?(params[:sort]) ? params[:sort] : 'name'
  end

  def sort_order
    ['asc', 'desc'].include?(params[:order]) ? params[:order] : 'asc'
  end

  def sort_order_next(column)
    return 'desc' if params[:order] == 'asc' && params[:sort] == column
    return 'asc' if params[:order] == 'desc' && params[:sort] == column
    'asc'
  end

  def authorizer_for_profiler
    Rack::MiniProfiler.authorize_request if current_user.try(:admin?)
  end

  def authorizer_for_scout_server_timing_profiler
    if current_user && current_user.admin?
      ServerTiming::Auth.ok!
    elsif Rails.env.development?
      ServerTiming::Auth.ok!
    else
      ServerTiming::Auth.deny!
    end
  end

  rescue_from ActiveRecord::RecordNotFound do
    render status: 404, file: "#{ Rails.root }/public/404.html", layout: false
  end

  rescue_from ActionController::BadRequest do
    redirect_to root_url
  end

  private

  def change_current_page_lang(url, lang)
    return "/#{ lang }" if url == '/'
    url[1, 2] = lang
    url
  end

  def prefered_locale
    return if browser.bot?

    http_accept_language.compatible_language_from(I18n.available_locales) || 'en'
  end
end
