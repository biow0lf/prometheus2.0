Prometheus20::Application.routes.draw do |map|
#  map.connect '/iphone/', :controller => 'iphone', :action => 'index'
#  map.connect '/:locale/iphone/', :controller => 'iphone', :action => 'index', :requirements => { :locale => /(en|ru|uk|br)/ }
#  map.connect '/iphone/packager/:login', :controller => 'iphone', :action => 'maintainer_info'
#  map.connect '/:locale/iphone/packager/:login', :controller => 'iphone', :action => 'maintainer_info', :requirements => { :locale => /(en|ru|uk|br)/ }
#
#  map.connect '/iphone/packages/:group', :controller => 'iphone', :action => 'bygroup'
#  map.connect '/:locale/iphone/packages/:group', :controller => 'iphone', :action => 'bygroup', :requirements => { :locale => /(en|ru|uk|br)/ }
#  map.connect '/iphone/packages/:group/:group2', :controller => 'iphone', :action => 'bygroup'
#  map.connect '/:locale/iphone/packages/:group/:group2', :controller => 'iphone', :action => 'bygroup', :requirements => { :locale => /(en|ru|uk|br)/ }
#  map.connect '/iphone/packages/:group/:group2/:group3', :controller => 'iphone', :action => 'bygroup'
#  map.connect '/:locale/iphone/packages/:group/:group2/:group3', :controller => 'iphone', :action => 'bygroup', :requirements => { :locale => /(en|ru|uk|br)/ }
#
#  map.connect '/search', :controller => 'home', :action => 'search'
#  map.connect '/:locale/search', :controller => 'home', :action => 'search', :requirements => { :locale => /(en|ru|uk|br)/ }
#  map.connect '/find.shtml', :controller => 'home', :action => 'search'
#  map.connect '/:locale/find.shtml', :controller => 'home', :action => 'search', :requirements => { :locale => /(en|ru|uk|br)/ }

  match '(/:locale)/news', :to => 'pages#news'#, :requirements => { :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/rss', :to => 'pages#rss'#, :requirements => { :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/security', :to => 'pages#security'#, :requirements => { :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/project', :to => 'pages#project'#, :requirements => { :locale => /(en|ru|uk|br)/ }

  match '(/:locale)/packages', :to => 'home#groups_list'#, :requirements => { :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/people', :to => 'home#maintainers_list'#, :requirements => { :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/team/:name', :to => 'team#info'#, :requirements => { :locale => /(en|ru|uk|br)/ }

  match '(/:locale)/packager/:login', :to => 'maintainer#info'#, :requirements => { :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/packager/:login/srpms', :to => 'maintainer#srpms'#, :requirements => { :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/packager/:login/acls', :to => 'maintainer#acls'#, :requirements => { :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/packager/:login/gear', :to => 'maintainer#gear'#, :requirements => { :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/packager/:login/bugs', :to => 'maintainer#bugs'#, :requirements => { :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/packager/:login/allbugs', :to => 'maintainer#allbugs'#, :requirements => { :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/packager/:login/repocop', :to => 'maintainer#repocop'#, :requirements => { :locale => /(en|ru|uk|br)/ }
#  match '(/:locale)/packager/:login/repocop/rss', :to => 'maintainer#repocop'

  match '(/:locale)/packages/:group(/:group2(/:group3))', :to => 'home#bygroup'#, :requirements => { :locale => /(en|ru|uk|br)/ }

  match '(/:locale)/srpm/:branch/:name', :to => 'srpm#main'#, :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/srpm/:branch/:name/changelog', :to => 'srpm#changelog'#, :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/srpm/:branch/:name/spec', :to => 'srpm#rawspec'#, :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/srpm/:branch/:name/get', :to => 'srpm#download'#, :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/srpm/:branch/:name/gear', :to => 'srpm#gear'#, :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/srpm/:branch/:name/bugs', :to => 'srpm#bugs'#, :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/srpm/:branch/:name/allbugs', :to => 'srpm#allbugs'#, :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk|br)/ }
  match '(/:locale)/srpm/:branch/:name/repocop', :to => 'srpm#repocop'#, :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk|br)/ }
#  match '(/:locale)/srpm/:branch/:name/repocop.:format', :to => 'home#repocop'#, :requirements => { :name => /[^\/]+/ }

#  map.connect '/repocop', :controller => 'repocop', :action => 'index'
#  map.connect '/repocop/by-test/:testname', :controller => 'repocop', :action => 'bytest'

#???  map.connect '/:locale', :controller => 'home', :action => 'index', :requirements => { :locale => /(en|ru|uk|br)/ }

  root :to => "home#index"

#  map.sitemap '/sitemap.xml', :controller => 'sitemap', :action => 'sitemap_full'
#  map.connect '/sitemap_basic.xml', :controller => 'sitemap', :action => 'sitemap_basic'
#  map.connect '/:locale/sitemap1.xml', :controller => 'sitemap', :action => 'sitemap_part1', :requirements => { :locale => /(en|ru|uk|br)/ }
#  map.connect '/:locale/sitemap2.xml', :controller => 'sitemap', :action => 'sitemap_part2', :requirements => { :locale => /(en|ru|uk|br)/ }
#  map.connect '/:locale/sitemap3.xml', :controller => 'sitemap', :action => 'sitemap_part3', :requirements => { :locale => /(en|ru|uk|br)/ }
end