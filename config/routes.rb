SUPPORTED_LOCALES = /(en|ru|uk|br)/

Prometheus20::Application.routes.draw do |map|
  match '(/:locale)/iphone/' => 'iphone#index', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/iphone/packager/:login' => 'iphone#maintainer_info', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/iphone/packages/:group(/:group2(/:group3))' => 'iphone#bygroup', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/search' => 'home#search', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/find.shtml' => 'home#search', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/news' => 'pages#news', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/rss' => 'pages#rss', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/security' => 'pages#security', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/project' => 'pages#project', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/packages' => 'home#groups_list', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/people' => 'home#maintainers_list', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/team/:name' => 'team#info', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/packager/:login' => 'maintainer#info', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/srpms' => 'maintainer#srpms', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/acls' => 'maintainer#acls', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/gear' => 'maintainer#gear', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/bugs' => 'maintainer#bugs', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/allbugs' => 'maintainer#allbugs', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/repocop' => 'maintainer#repocop', :constraints => { :locale => SUPPORTED_LOCALES }
#  match '(/:locale)/packager/:login/repocop/rss' => 'maintainer#repocop', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/packages/:group(/:group2(/:group3))' => 'home#bygroup', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/srpm/:branch/:name' => 'srpm#main', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/changelog' => 'srpm#changelog', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/spec' => 'srpm#rawspec', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/get' => 'srpm#download', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/gear' => 'srpm#gear', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/bugs' => 'srpm#bugs', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/allbugs' => 'srpm#allbugs', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/repocop' => 'srpm#repocop', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
#  match '(/:locale)/srpm/:branch/:name/repocop.:format' => 'home#repocop', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }

#  match '/repocop' => 'repocop#index'
#  match '/repocop/by-test/:testname' => 'repocop#bytest'

#  match '(/:locale)/cli/count/:branch/:vendor/' => 'cli#count'

#  match '(/:locale)/cli/maintainers' => 'cli#maintainers'
#  match '(/:locale)/cli/maintainer/:login' => 'cli#maintainer_name'
#  match '(/:locale)/cli/maintainer/:login/acl' => 'cli#maintainer_acl'
#  match '(/:locale)/cli/maintainer/:login/gear' => 'cli#maintainer_gear'
#  match '(/:locale)/cli/maintainer/:login/bugs' => 'cli#maintainer_bugs'
#  match '(/:locale)/cli/maintainer/:login/allbugs' => 'cli#maintainer_allbugs'
#  match '(/:locale)/cli/maintainer/:login/repocop' => 'cli#maintainer_repocop'

  match '(/:locale)/cli/srpm/:branch/:vendor/:name' => 'cli#srpm_info', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/cli/srpm/:branch/:vendor/:name/changelog' => 'cli#srpm_changelog', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/cli/srpm/:branch/:vendor/:name/spec' => 'cli#srpm_spec', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/cli/srpm/:branch/:vendor/:name/get' => 'cli#srpm_get', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/cli/srpm/:branch/:vendor/:name/gear' => 'cli#srpm_gear', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/cli/srpm/:branch/:vendor/:name/bugs' => 'cli#srpm_bugs', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/cli/srpm/:branch/:vendor/:name/allbugs' => 'cli#srpm_allbugs', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/cli/srpm/:branch/:vendor/:name/repocop' => 'cli#srpm_repocop', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/cli/repocop/by-test/missing_url' => 'repocop#missing_url', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/cli/repocop/by-test/vendor_tag' => 'repocop#vendor_tag', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/cli/repocop/by-test/distribution_tag' => 'repocop#distribution_tag', :constraints => { :locale => SUPPORTED_LOCALES }

#  match '(/:locale)/cli/repocop/by-test/:name' => 'repocop#bytestname', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)' => 'home#index', :constraints => { :locale => SUPPORTED_LOCALES }

  root :to => "home#index"

  match '/sitemap.xml' => 'sitemap#sitemap_full'
  match '/sitemap_basic.xml' => 'sitemap#sitemap_basic'
  match '/:locale/sitemap1.xml' => 'sitemap#sitemap_part1', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/:locale/sitemap2.xml' => 'sitemap#sitemap_part2', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/:locale/sitemap3.xml' => 'sitemap#sitemap_part3', :constraints => { :locale => SUPPORTED_LOCALES }
end