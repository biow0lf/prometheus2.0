module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title.html_safe }
  end

  def keywords(string)
    # http://en.wikipedia.org/wiki/Most_common_words_in_English
    skiplist = %w(the be to of and a in i it for not on he as you do at this but his by from or an)
    content_for(:keywords) { (string.split(' ') - skiplist).join(', ') }
  end

  def description(string)
    content_for(:description) { string }
  end

  def current_page(url, lang)
    return "/#{lang}" if url == '/'
    url[1, 2] = lang
    url
  end
end
