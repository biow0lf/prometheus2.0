SUPPORTED_LOCALES = /(en|ru|uk|br)/

Prometheus20::Application.routes.draw do
  scope ':locale', :locale => SUPPORTED_LOCALES do
    devise_for :users

    match 'project' => 'pages#project'
    match 'news' => 'pages#news'
    resource :search, :only => :show, :id => /[^\/]+/

    resources :rsync, :controller => :rsync, :only => :new

    resource :maintainer_profile, :only => [:edit, :update]

    scope 'Sisyphus' do
      match 'maintainers/:id/gear' => 'maintainers#gear', :as => 'gear_maintainer'
      match 'maintainers/:id/bugs' => 'maintainers#bugs', :as => 'bugs_maintainer'
      match 'maintainers/:id/allbugs' => 'maintainers#allbugs', :as => 'allbugs_maintainer'
      match 'maintainers/:id/repocop' => 'maintainers#repocop', :as => 'repocop_maintainer'
    end

    scope 'Sisyphus', :id => /[^\/]+/ do
      match 'srpms/:id/gear' => 'srpms#gear', :as => 'gear_srpm'
      match 'srpms/:id/bugs' => 'srpms#bugs', :as => 'bugs_srpm'
      match 'srpms/:id/allbugs' => 'srpms#allbugs', :as => 'allbugs_srpm'
      match 'srpms/:id/repocop' => 'srpms#repocop', :as => 'repocop_srpm'
    end

    scope ':branch', :branch => /[^\/]+/ do
      resources :maintainers, :only => :show do
        get 'srpms', :on => :member
      end
      resources :teams, :only => :show

      resources :srpms, :id => /[^\/]+/, :only => :show do
        member do
          get 'changelog'
          get 'spec'
          get 'get'
        end
      end

      match 'home' => 'home#index'

      match 'packages/:group(/:group2(/:group3))' => 'group#bygroup', :as => 'group'
      match 'packages' => 'group#groups_list', :as => 'packages'
      match 'people' => 'home#maintainers_list', :as => 'maintainers'
      match 'rss' => 'rss#index', :as => 'rss'

    end

    root :to => 'home#index'
  end

  match '(/:locale)/misc/bugs' => 'misc#bugs', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/iphone/' => 'iphone#index', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/iphone/packager/:login' => 'iphone#maintainer_info', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/iphone/packages/:group(/:group2(/:group3))' => 'iphone#bygroup', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/security' => 'pages#security', :as => 'security', :constraints => { :locale => SUPPORTED_LOCALES }

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

  match '/cli/repocop/by-test/no_url_tag' => 'repocop#no_url_tag'
  match '/cli/repocop/by-test/invalid_url' => 'repocop#invalid_url'
  match '/cli/repocop/by-test/invalid_vendor' => 'repocop#invalid_vendor'
  match '/cli/repocop/by-test/invalid_distribution' => 'repocop#invalid_distribution'
  match '/cli/repocop/by-test/srpms_summary_too_long' => 'repocop#srpms_summary_too_long'
  match '/cli/repocop/by-test/packages_summary_too_long' => 'repocop#packages_summary_too_long'
  match '/cli/repocop/by-test/srpms_summary_ended_with_dot' => 'repocop#srpms_summary_ended_with_dot'
  match '/cli/repocop/by-test/packages_summary_ended_with_dot' => 'repocop#packages_summary_ended_with_dot'

#  match '/cli/repocop/by-test/:name' => 'repocop#bytestname'

  match '/sitemap.xml' => 'sitemap#sitemap'
  match '/sitemap_basic.xml' => 'sitemap#sitemap_basic'
  match '/:locale/sitemap1.xml' => 'sitemap#sitemap_part1', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/:locale/sitemap2.xml' => 'sitemap#sitemap_part2', :constraints => { :locale => SUPPORTED_LOCALES }
  match '/:locale/sitemap3.xml' => 'sitemap#sitemap_part3', :constraints => { :locale => SUPPORTED_LOCALES }

  match '/src\::name' => redirect("/en/Sisyphus/srpms/%{name}"), :constraints => { :name => /[^\/]+/ }
  match '/:name' => 'redirector#index', :constraints => { :name => /[^\/]+/ }
end
