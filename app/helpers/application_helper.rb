# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def url(string)
    content_for(:url) { string }
  end

  def srpm_count(srpm_count)
    content_for(:srpms_counter) { srpm_count }
  end
end
