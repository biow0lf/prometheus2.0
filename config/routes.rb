ActionController::Routing::Routes.draw do |map|
  map.connect '/iphone/', :controller => 'iphone', :action => 'index'
  map.connect '/:locale/iphone/', :controller => 'iphone', :action => 'index', :requirements => { :locale => /(en|ru|uk|br)/ }
  map.connect '/iphone/packager/:login', :controller => 'iphone', :action => 'packager_info'
  map.connect '/:locale/iphone/packager/:login', :controller => 'iphone', :action => 'packager_info', :requirements => { :locale => /(en|ru|uk|br)/ }

  map.connect '/search', :controller => 'home', :action => 'search'
  map.connect '/:locale/search', :controller => 'home', :action => 'search', :requirements => { :locale => /(en|ru|uk|br)/ }
  map.connect '/find.shtml', :controller => 'home', :action => 'search'
  map.connect '/:locale/find.shtml', :controller => 'home', :action => 'search', :requirements => { :locale => /(en|ru|uk|br)/ }

  map.connect '/news', :controller => 'pages', :action => 'news'	 	
  map.connect '/:locale/news', :controller => 'pages', :action => 'news', :requirements => { :locale => /(en|ru|uk|br)/ }

  map.connect '/rss', :controller => 'pages', :action => 'rss'	 	
  map.connect '/:locale/rss', :controller => 'pages', :action => 'rss', :requirements => { :locale => /(en|ru|uk|br)/ }

  map.connect '/security', :controller => 'pages', :action => 'security'
  map.connect '/:locale/security', :controller => 'pages', :action => 'security', :requirements => { :locale => /(en|ru|uk|br)/ }

  map.connect '/project', :controller => 'pages', :action => 'project'
  map.connect '/:locale/project', :controller => 'pages', :action => 'project', :requirements => { :locale => /(en|ru|uk|br)/ }

  map.connect '/packages', :controller => 'home', :action => 'groups_list'
  map.connect '/:locale/packages', :controller => 'home', :action => 'groups_list', :requirements => { :locale => /(en|ru|uk|br)/ }

  map.connect '/people', :controller => 'home', :action => 'packagers_list'
  map.connect '/:locale/people', :controller => 'home', :action => 'packagers_list', :requirements => { :locale => /(en|ru|uk|br)/ }

  map.connect '/team/:name', :controller => 'team', :action => 'info'
  map.connect '/:locale/team/:name', :controller => 'team', :action => 'info', :requirements => { :locale => /(en|ru|uk|br)/ }

  map.connect '/packager/:login', :controller => 'maintainer', :action => 'info'
  map.connect '/:locale/packager/:login', :controller => 'maintainer', :action => 'info', :requirements => { :locale => /(en|ru|uk|br)/ }
  map.connect '/packager/:login/srpms', :controller => 'maintainer', :action => 'srpms'
  map.connect '/:locale/packager/:login/srpms', :controller => 'maintainer', :action => 'srpms', :requirements => { :locale => /(en|ru|uk|br)/ }
  map.connect '/packager/:login/acls', :controller => 'maintainer', :action => 'acls'
  map.connect '/:locale/packager/:login/acls', :controller => 'maintainer', :action => 'acls', :requirements => { :locale => /(en|ru|uk|br)/ }
  map.connect '/packager/:login/gear', :controller => 'maintainer', :action => 'gear'
  map.connect '/:locale/packager/:login/gear', :controller => 'maintainer', :action => 'gear', :requirements => { :locale => /(en|ru|uk|br)/ }
  map.connect '/packager/:login/bugs', :controller => 'maintainer', :action => 'bugs'
  map.connect '/:locale/packager/:login/bugs', :controller => 'maintainer', :action => 'bugs', :requirements => { :locale => /(en|ru|uk|br)/ }
  map.connect '/packager/:login/allbugs', :controller => 'maintainer', :action => 'allbugs'
  map.connect '/:locale/packager/:login/allbugs', :controller => 'maintainer', :action => 'allbugs', :requirements => { :locale => /(en|ru|uk|br)/ }
  map.connect '/packager/:login/repocop', :controller => 'maintainer', :action => 'repocop'
  map.connect '/:locale/packager/:login/repocop', :controller => 'maintainer', :action => 'repocop', :requirements => { :locale => /(en|ru|uk|br)/ }
#  map.connect '/packager/:login/repocop/rss', :controller => 'maintainer', :action => 'repocop'
#  map.connect '/:locale/packager/:login/repocop/rss', :controller => 'maintainer', :action => 'repocop'

  map.connect '/packages/:group', :controller => 'home', :action => 'bygroup'
  map.connect '/:locale/packages/:group', :controller => 'home', :action => 'bygroup', :requirements => { :locale => /(en|ru|uk|br)/ }
  map.connect '/packages/:group/:group2', :controller => 'home', :action => 'bygroup'
  map.connect '/:locale/packages/:group/:group2', :controller => 'home', :action => 'bygroup', :requirements => { :locale => /(en|ru|uk|br)/ }
  map.connect '/packages/:group/:group2/:group3', :controller => 'home', :action => 'bygroup'
  map.connect '/:locale/packages/:group/:group2/:group3', :controller => 'home', :action => 'bygroup', :requirements => { :locale => /(en|ru|uk|br)/ }

  map.connect '/srpm/:branch/:name', :controller => 'srpm', :action => 'main', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/ }
  map.connect '/:locale/srpm/:branch/:name', :controller => 'srpm', :action => 'main', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk|br)/ }
  map.connect '/srpm/:branch/:name/changelog', :controller => 'srpm', :action => 'changelog', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/ }
  map.connect '/:locale/srpm/:branch/:name/changelog', :controller => 'srpm', :action => 'changelog', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk|br)/ }
  map.connect '/srpm/:branch/:name/spec', :controller => 'srpm', :action => 'rawspec', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/ }
  map.connect '/:locale/srpm/:branch/:name/spec', :controller => 'srpm', :action => 'rawspec', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk|br)/ }
  map.connect '/srpm/:branch/:name/get', :controller => 'srpm', :action => 'download', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/ }
  map.connect '/:locale/srpm/:branch/:name/get', :controller => 'srpm', :action => 'download', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk|br)/ }
  map.connect '/srpm/:branch/:name/gear', :controller => 'srpm', :action => 'gear', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/ }
  map.connect '/:locale/srpm/:branch/:name/gear', :controller => 'srpm', :action => 'gear', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk|br)/ }
  map.connect '/srpm/:branch/:name/bugs', :controller => 'srpm', :action => 'bugs', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/ }
  map.connect '/:locale/srpm/:branch/:name/bugs', :controller => 'srpm', :action => 'bugs', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk|br)/ }
  map.connect '/srpm/:branch/:name/allbugs', :controller => 'srpm', :action => 'allbugs', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/ }
  map.connect '/:locale/srpm/:branch/:name/allbugs', :controller => 'srpm', :action => 'allbugs', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk|br)/ }
  map.connect '/srpm/:branch/:name/repocop', :controller => 'srpm', :action => 'repocop', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/ }
  map.connect '/:locale/srpm/:branch/:name/repocop', :controller => 'srpm', :action => 'repocop', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk|br)/ }
#  map.connect '/srpm/:branch/:name/repocop.:format', :controller => 'home', :action => 'repocop', :requirements => { :name => /[^\/]+/ }
#  map.connect '/:locale/srpm/:branch/:name/repocop.:format', :controller => 'home', :action => 'repocop', :requirements => { :name => /[^\/]+/ }

#  map.connect '/repocop', :controller => 'repocop', :action => 'index'
#  map.connect '/repocop/by-test/:testname', :controller => 'repocop', :action => 'bytest'

  map.connect '/:locale', :controller => 'home', :action => 'index', :requirements => { :locale => /(en|ru|uk|br)/ }

  map.root :controller => 'home'

  map.sitemap '/sitemap.xml', :controller => 'sitemap', :action => 'sitemap_full'
  map.connect '/sitemap_basic.xml', :controller => 'sitemap', :action => 'sitemap_basic'
  map.connect '/:locale/sitemap1.xml', :controller => 'sitemap', :action => 'sitemap_part1', :requirements => { :locale => /(en|ru|uk|br)/ }
  map.connect '/:locale/sitemap2.xml', :controller => 'sitemap', :action => 'sitemap_part2', :requirements => { :locale => /(en|ru|uk|br)/ }
end
