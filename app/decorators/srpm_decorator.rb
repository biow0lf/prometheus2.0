class SrpmDecorator < Draper::Decorator
  delegate_all

  def short_url
    if object.url
      if object.url.length > 27
        h.link_to "#{object.url[0..26]}...", object.url, class: 'news', rel: 'nofollow'
      else
        h.link_to object.url, object.url, class: 'news', rel: 'nofollow'
      end
    else
      "&ndash;".html_safe
    end
  end
end
