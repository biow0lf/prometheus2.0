class RssController < ApplicationController
  def index
    @branch = Branch.find_by!(name: params[:branch])
    @srpms = @branch.srpms.where('srpms.created_at > ?', Time.now - 2.days).order('srpms.created_at DESC').decorate
    render layout: nil
    response.headers['Content-Type'] = 'application/xml; charset=utf-8'
  end
end
