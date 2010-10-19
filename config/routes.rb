SUPPORTED_LOCALES = /(en|ru|uk|br)/

Prometheus20::Application.routes.draw do |map|
  match '(/:locale)/iphone/', :to => 'iphone#index', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/iphone/packager/:login', :to => 'iphone#maintainer_info', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/iphone/packages/:group(/:group2(/:group3))', :to => 'iphone#bygroup', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/search', :to => 'home#search', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/find.shtml', :to => 'home#search', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/news', :to => 'pages#news', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/rss', :to => 'pages#rss', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/security', :to => 'pages#security', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/project', :to => 'pages#project', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/packages', :to => 'home#groups_list', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/people', :to => 'home#maintainers_list', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/team/:name', :to => 'team#info', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/packager/:login', :to => 'maintainer#info', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/srpms', :to => 'maintainer#srpms', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/acls', :to => 'maintainer#acls', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/gear', :to => 'maintainer#gear', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/bugs', :to => 'maintainer#bugs', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/allbugs', :to => 'maintainer#allbugs', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/repocop', :to => 'maintainer#repocop', :constraints => { :locale => SUPPORTED_LOCALES }
#  match '(/:locale)/packager/:login/repocop/rss', :to => 'maintainer#repocop', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/packages/:group(/:group2(/:group3))', :to => 'home#bygroup', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/srpm/:branch/:name', :to => 'srpm#main', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/changelog', :to => 'srpm#changelog', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/spec', :to => 'srpm#rawspec', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/get', :to => 'srpm#download', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/gear', :to => 'srpm#gear', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/bugs', :to => 'srpm#bugs', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/allbugs', :to => 'srpm#allbugs', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/repocop', :to => 'srpm#repocop', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
#  match '(/:locale)/srpm/:branch/:name/repocop.:format', :to => 'home#repocop', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }

#  map.connect '/repocop', :controller => 'repocop', :action => 'index'
#  map.connect '/repocop/by-test/:testname', :controller => 'repocop', :action => 'bytest'

  match '(/:locale)', :to => 'home#index', :constraints => { :locale => SUPPORTED_LOCALES }

  root :to => "home#index"

  match '/sitemap.xml', :to => 'sitemap#sitemap_full'
  match '/sitemap_basic.xml', :to => 'sitemap#sitemap_basic'
  match '/:locale/sitemap1.xml', :to => 'sitemap#sitemap_part1', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/:locale/sitemap2.xml', :to => 'sitemap#sitemap_part2', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/:locale/sitemap3.xml', :to => 'sitemap#sitemap_part3', :constraints => { :locale => SUPPORTED_LOCALES }
end