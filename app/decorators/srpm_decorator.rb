class SrpmDecorator < Draper::Decorator
  delegate_all

  def short_url
    if object.url
      if object.url.length > 27
        local_link_to("#{object.url[0..26]}...", object.url)
      else
        local_link_to(object.url, object.url)
      end
    else
      '&ndash;'.html_safe
    end
  end

  private

  def local_link_to(text, url)
    h.link_to(text, url, class: 'news', rel: 'nofollow')
  end
end
