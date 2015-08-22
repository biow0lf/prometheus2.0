class SrpmDecorator < Draper::Decorator
  delegate_all

  def short_url
    if url
      create_link(url)
    else
      '&ndash;'.html_safe
    end
  end

  def evr
    if epoch
      "#{ epoch }:#{ version }-#{ release }"
    else
      "#{ version }-#{ release }"
    end
  end

  private

  def create_link(url)
    if url.length > 27
      local_link_to("#{ url[0..26] }...", url)
    else
      local_link_to(url, url)
    end
  end

  def local_link_to(text, url)
    h.link_to(text, url, class: 'news', rel: 'nofollow')
  end
end
