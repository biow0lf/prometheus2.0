SUPPORTED_LOCALES = /(en|ru|uk|br)/

Prometheus20::Application.routes.draw do |map|
  match '(/:locale)/misc/bugs' => 'misc#bugs', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/iphone/' => 'iphone#index', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/iphone/packager/:login' => 'iphone#maintainer_info', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/iphone/packages/:group(/:group2(/:group3))' => 'iphone#bygroup', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/search' => 'home#search', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/find.shtml' => 'home#search', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/news' => 'pages#news', :as => 'news', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/rss' => 'pages#rss', :as => 'rss', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/security' => 'pages#security', :as => 'security', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/project' => 'pages#project', :as => 'project', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/rsync.shtml' => 'rsync#index', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/rsync' => 'rsync#index', :as => 'rsync', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/packages' => 'home#groups_list', :as => 'packages', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/people' => 'home#maintainers_list', :as => 'maintainers', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/team/:name' => 'team#info', :as => 'team', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/packager/:login' => 'maintainer#info', :as => 'maintainer_info', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/srpms' => 'maintainer#srpms', :as => 'maintainer_srpms', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/acls' => 'maintainer#acls', :as => 'maintainer_acls', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/gear' => 'maintainer#gear', :as => 'maintainer_gear', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/bugs' => 'maintainer#bugs', :as => 'maintainer_bugs', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/allbugs' => 'maintainer#allbugs', :as => 'maintainer_allbugs', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/repocop' => 'maintainer#repocop', :as => 'maintainer_repocop', :constraints => { :locale => SUPPORTED_LOCALES }
#  match '(/:locale)/packager/:login/repocop/rss' => 'maintainer#repocop', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/packages/:group(/:group2(/:group3))' => 'home#bygroup', :as => 'group', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/srpm/:branch/:name' => 'srpm#main', :as => 'srpm_main', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/changelog' => 'srpm#changelog', :as => 'srpm_changelog', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/spec' => 'srpm#rawspec', :as => 'srpm_rawspec', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/get' => 'srpm#download', :as => 'srpm_download', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/gear' => 'srpm#gear', :as => 'srpm_gear', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/bugs' => 'srpm#bugs', :as => 'srpm_bugs', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/allbugs' => 'srpm#allbugs', :as => 'srpm_allbugs', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/repocop' => 'srpm#repocop', :as => 'srpm_repocop', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
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

  match '/cli/srpm/:vendor/:branch/:name' => 'cli#srpm_info', :constraints => { :locale => SUPPORTED_LOCALES }
  #match '/cli/srpm/:vendor/:branch/:name/acls' => 'cli#srpm_acls', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/cli/srpm/:vendor/:branch/:name/changelog' => 'cli#srpm_changelog', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/cli/srpm/:vendor/:branch/:name/spec' => 'cli#srpm_spec', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/cli/srpm/:vendor/:branch/:name/get' => 'cli#srpm_get', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/cli/srpm/:vendor/:branch/:name/gear' => 'cli#srpm_gear', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/cli/srpm/:vendor/:branch/:name/bugs' => 'cli#srpm_bugs', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/cli/srpm/:vendor/:branch/:name/allbugs' => 'cli#srpm_allbugs', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/cli/srpm/:vendor/:branch/:name/repocop' => 'cli#srpm_repocop', :constraints => { :locale => SUPPORTED_LOCALES }

  match '/cli/repocop/by-test/missing_url' => 'repocop#missing_url', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/cli/repocop/by-test/vendor_tag' => 'repocop#vendor_tag', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/cli/repocop/by-test/distribution_tag' => 'repocop#distribution_tag', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/cli/repocop/by-test/invalid_url' => 'repocop#invalid_url', :constraints => { :locale => SUPPORTED_LOCALES }

#  match '/cli/repocop/by-test/:name' => 'repocop#bytestname', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)' => 'home#index', :as => 'home', :constraints => { :locale => SUPPORTED_LOCALES }
  
  match '/src\::name' => redirect {|params| "/en/srpm/Sisyphus/#{params[:name]}"}
  match '/:name' => 'redirector#index'

  root :to => "home#index"

  match '/sitemap.xml' => 'sitemap#sitemap_full'
  match '/sitemap_basic.xml' => 'sitemap#sitemap_basic'
  match '/:locale/sitemap1.xml' => 'sitemap#sitemap_part1', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/:locale/sitemap2.xml' => 'sitemap#sitemap_part2', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/:locale/sitemap3.xml' => 'sitemap#sitemap_part3', :constraints => { :locale => SUPPORTED_LOCALES }
end