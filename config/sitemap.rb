# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://packages.altlinux.org"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  ['en', 'ru', 'uk', 'br'].each do |locale|
    Branch.find_each do |branch|
      branch.srpms.each do |srpm|
        add srpm_path(locale, branch, srpm)
        add changelog_srpm_path(locale, branch, srpm)
        add spec_srpm_path(locale, branch, srpm)
        add get_srpm_path(locale, branch, srpm)
        add gear_srpm_path(locale, srpm)
        add bugs_srpm_path(locale, srpm)
        add allbugs_srpm_path(locale, srpm)
        add repocop_srpm_path(locale, srpm)
      end
    end
  end
end
