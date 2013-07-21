class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_default_locale
  before_filter :set_default_branch
  before_filter :add_view_path_for_redesign

  helper_method :sort_column, :sort_order, :sort_order_next

  def set_default_locale
    params[:locale] ||= 'en'
    I18n.locale = params[:locale]
    FastGettext.locale = params[:locale]
  end

  def set_default_branch
    params[:branch] ||= 'Sisyphus'
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
  end

  def default_url_options(options = {})
    { locale: I18n.locale }
  end

  def load_branch
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
  end

  def sort_column
    %w[status name age].include?(params[:sort]) ? params[:sort] : 'name'
  end

  def sort_order
    %w[asc desc].include?(params[:order]) ? params[:order] : 'asc'
  end

  def sort_order_next(column)
    return 'desc' if params[:order] == 'asc' && params[:sort] == column
    return 'asc' if params[:order] == 'desc' && params[:sort] == column
    'asc'
  end

  private

  def add_view_path_for_redesign
    if current_user && current_user.newdesign?
      prepend_view_path Rails.root.join('app/views/bootstrap')
    end
  end
end
