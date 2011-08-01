# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title.html_safe }
  end

  def srpm_count(srpm_count)
    content_for(:srpms_counter) { srpm_count }
  end

  def keywords(string)
    # http://en.wikipedia.org/wiki/Most_common_words_in_English
    skiplist = "the be to of and a in i it for not on he as you do at this but his by from or an".split(' ')
    content_for(:keywords) { (string.split(' ') - skiplist).join(', ') }
  end

  def description(string)
    content_for(:description) { string }
  end

  def avatar_url(maintainer)
    gravatar_id = Digest::MD5.hexdigest(maintainer.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=80&r=g"
  end

  def current_page(url, lang)
    return "/#{lang}" if url == '/'
    url[1,2] = lang
    url
  end
end
