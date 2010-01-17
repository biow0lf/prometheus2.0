ActionController::Routing::Routes.draw do |map|
#  map.connect ':locale/top15', :controller => 'home', :action => 'top15'
#  map.connect 'top15', :controller => 'home', :action => 'top15'

#  map.connect ':locale/stats', :controller => 'home', :action => 'stats'
#  map.connect 'stats', :controller => 'home', :action => 'stats'

  map.connect '/iphone/', :controller => 'iphone', :action => 'index'
  map.connect ':locale/iphone/', :controller => 'iphone', :action => 'index', :requirements => { :locale => /(en|ru|uk)/ }
  map.connect '/iphone/packager/:login', :controller => 'iphone', :action => 'packager_info'
  map.connect ':locale/iphone/packager/:login', :controller => 'iphone', :action => 'packager_info', :requirements => { :locale => /(en|ru|uk)/ }

  map.connect '/search', :controller => 'home', :action => 'search'
  map.connect ':locale/search', :controller => 'home', :action => 'search', :requirements => { :locale => /(en|ru|uk)/ }
  map.connect '/find.shtml', :controller => 'home', :action => 'search'
  map.connect ':locale/find.shtml', :controller => 'home', :action => 'search', :requirements => { :locale => /(en|ru|uk)/ }

  map.connect 'packages', :controller => 'home', :action => 'groups_list'
  map.connect ':locale/packages', :controller => 'home', :action => 'groups_list', :requirements => { :locale => /(en|ru|uk)/ }

  map.connect 'people', :controller => 'home', :action => 'packagers_list'
  map.connect ':locale/people', :controller => 'home', :action => 'packagers_list', :requirements => { :locale => /(en|ru|uk)/ }

  map.connect 'team/:name', :controller => 'team', :action => 'info'
  map.connect ':locale/team/:name', :controller => 'team', :action => 'info', :requirements => { :locale => /(en|ru|uk)/ }

  map.connect 'packager/:login', :controller => 'packager', :action => 'info'
  map.connect ':locale/packager/:login', :controller => 'packager', :action => 'info', :requirements => { :locale => /(en|ru|uk)/ }
  map.connect 'packager/:login/srpms', :controller => 'packager', :action => 'srpms'
  map.connect ':locale/packager/:login/srpms', :controller => 'packager', :action => 'srpms', :requirements => { :locale => /(en|ru|uk)/ }
  map.connect 'packager/:login/acls', :controller => 'packager', :action => 'acls'
  map.connect ':locale/packager/:login/acls', :controller => 'packager', :action => 'acls', :requirements => { :locale => /(en|ru|uk)/ }
  map.connect 'packager/:login/gear', :controller => 'packager', :action => 'gear'
  map.connect ':locale/packager/:login/gear', :controller => 'packager', :action => 'gear', :requirements => { :locale => /(en|ru|uk)/ }
  map.connect 'packager/:login/bugs', :controller => 'packager', :action => 'bugs'
  map.connect ':locale/packager/:login/bugs', :controller => 'packager', :action => 'bugs', :requirements => { :locale => /(en|ru|uk)/ }
  map.connect 'packager/:login/allbugs', :controller => 'packager', :action => 'allbugs'
  map.connect ':locale/packager/:login/allbugs', :controller => 'packager', :action => 'allbugs', :requirements => { :locale => /(en|ru|uk)/ }
  map.connect 'packager/:login/repocop', :controller => 'packager', :action => 'repocop'
  map.connect ':locale/packager/:login/repocop', :controller => 'packager', :action => 'repocop', :requirements => { :locale => /(en|ru|uk)/ }
#  map.connect 'packager/:login/repocop/rss', :controller => 'packager', :action => 'repocop'
#  map.connect ':locale/packager/:login/repocop/rss', :controller => 'packager', :action => 'repocop'

  map.connect 'packages/:group', :controller => 'home', :action => 'bygroup'
  map.connect ':locale/packages/:group', :controller => 'home', :action => 'bygroup', :requirements => { :locale => /(en|ru|uk)/ }
  map.connect 'packages/:group/:group2', :controller => 'home', :action => 'bytwogroup'
  map.connect ':locale/packages/:group/:group2', :controller => 'home', :action => 'bytwogroup', :requirements => { :locale => /(en|ru|uk)/ }
  map.connect 'packages/:group/:group2/:group3', :controller => 'home', :action => 'bythreegroup'
  map.connect ':locale/packages/:group/:group2/:group3', :controller => 'home', :action => 'bythreegroup', :requirements => { :locale => /(en|ru|uk)/ }

#  map.connect 'srpm/:name', :controller => 'home', :action => 'srpm_info_sisyphus', :requirements => { :name => /.*/ }
#  map.connect 'srpm/:name', :controller => 'home', :action => 'srpm_info_sisyphus'

#  map.connect 'srpm/:branch/:name', :controller => 'srpm', :action => 'main', :name => nil, :requirements => { :name => /[^/]/ }
#  map.connect ':locale/srpm/:branch/:name', :controller => 'srpm', :action => 'main', :name => nil, :requirements => { :name => /[^/]/ }

  map.connect 'srpm/:branch/:name', :controller => 'srpm', :action => 'main', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/ }
  map.connect ':locale/srpm/:branch/:name', :controller => 'srpm', :action => 'main', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk)/ }
  map.connect 'srpm/:branch/:name/changelog', :controller => 'srpm', :action => 'changelog', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/ }
  map.connect ':locale/srpm/:branch/:name/changelog', :controller => 'srpm', :action => 'changelog', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk)/ }
  map.connect 'srpm/:branch/:name/spec', :controller => 'srpm', :action => 'rawspec', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/ }
  map.connect ':locale/srpm/:branch/:name/spec', :controller => 'srpm', :action => 'rawspec', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk)/ }
  map.connect 'srpm/:branch/:name/get', :controller => 'srpm', :action => 'download', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/ }
  map.connect ':locale/srpm/:branch/:name/get', :controller => 'srpm', :action => 'download', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk)/ }
  map.connect 'srpm/:branch/:name/gear', :controller => 'srpm', :action => 'gear', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/ }
  map.connect ':locale/srpm/:branch/:name/gear', :controller => 'srpm', :action => 'gear', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk)/ }
  map.connect 'srpm/:branch/:name/bugs', :controller => 'srpm', :action => 'bugs', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/ }
  map.connect ':locale/srpm/:branch/:name/bugs', :controller => 'srpm', :action => 'bugs', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk)/ }
  map.connect 'srpm/:branch/:name/allbugs', :controller => 'srpm', :action => 'allbugs', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/ }
  map.connect ':locale/srpm/:branch/:name/allbugs', :controller => 'srpm', :action => 'allbugs', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk)/ }
  map.connect 'srpm/:branch/:name/repocop', :controller => 'srpm', :action => 'repocop', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/ }
  map.connect ':locale/srpm/:branch/:name/repocop', :controller => 'srpm', :action => 'repocop', :requirements => { :branch => /[^\/]+/, :name => /[^\/]+/, :locale => /(en|ru|uk)/ }
#  map.connect 'srpm/:branch/:name/repocop.:format', :controller => 'home', :action => 'repocop', :requirements => { :name => /[^\/]+/ }
#  map.connect ':locale/srpm/:branch/:name/repocop.:format', :controller => 'home', :action => 'repocop', :requirements => { :name => /[^\/]+/ }

#  map.connect 'repocop', :controller => 'repocop', :action => 'index'
#  map.connect 'repocop/by-test/:testname', :controller => 'repocop', :action => 'bytest'

  map.connect 'project', :controller => 'home', :action => 'project'
  map.connect ':locale/project', :controller => 'home', :action => 'project', :requirements => { :locale => /(en|ru|uk)/ }
  map.connect 'security', :controller => 'home', :action => 'security'
  map.connect ':locale/security', :controller => 'home', :action => 'security', :requirements => { :locale => /(en|ru|uk)/ }
  map.connect 'news', :controller => 'home', :action => 'news'
  map.connect ':locale/news', :controller => 'home', :action => 'news', :requirements => { :locale => /(en|ru|uk)/ }
  map.connect 'rss', :controller => 'home', :action => 'rss'
  map.connect ':locale/rss', :controller => 'home', :action => 'rss', :requirements => { :locale => /(en|ru|uk)/ }

  map.connect ':locale', :controller => 'home', :action => 'index', :requirements => { :locale => /(en|ru|uk)/ }

  map.root :controller => 'home'

  map.sitemap '/sitemap.xml', :controller => 'sitemap', :action => 'sitemap_full'
  map.connect '/sitemap_basic.xml', :controller => 'sitemap', :action => 'sitemap_basic'
  map.connect '/sitemap_en1.xml', :controller => 'sitemap', :action => 'sitemap_en1'
  map.connect '/sitemap_en2.xml', :controller => 'sitemap', :action => 'sitemap_en2'
  map.connect '/sitemap_ru1.xml', :controller => 'sitemap', :action => 'sitemap_ru1'
  map.connect '/sitemap_ru2.xml', :controller => 'sitemap', :action => 'sitemap_ru2'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
