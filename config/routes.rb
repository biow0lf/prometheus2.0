# encoding: utf-8

Prometheus20::Application.routes.draw do
  scope '(:locale)', :locale => SUPPORTED_LOCALES do
    devise_for :users
    resource :maintainer_profile, :only => [:edit, :update]
    resource :search, :only => :show, :id => /[^\/]+/
    root :to => 'home#index'

    match 'm/' => 'iphone#index', :as => 'iphone_home'
    match 'm/maintainer/:login' => 'iphone#maintainer_info', :as => 'iphone_maintainer'
    match 'm/packages/:group(/:group2(/:group3))' => 'iphone#bygroup', :as => 'iphone_group'
  end

  scope ':locale', :locale => SUPPORTED_LOCALES do
    match 'project' => 'pages#project'
    resources :rsync, :controller => :rsync, :only => [:new]
    resources :rebuild, :controller => :rebuild, :only => [:index]

    scope 'Sisyphus' do
      match 'maintainers/:id/gear' => 'maintainers#gear', :as => 'gear_maintainer'
      match 'maintainers/:id/bugs' => 'maintainers#bugs', :as => 'bugs_maintainer'
      match 'maintainers/:id/allbugs' => 'maintainers#allbugs', :as => 'allbugs_maintainer'
      match 'maintainers/:id/ftbfs' => 'maintainers#ftbfs', :as => 'ftbfs_maintainer'
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
          get 'rawspec'
          get 'get'
        end
        resources :patches, :only => [:index, :show]
        resources :sources, :only => :index do
          member do
            get 'download'
          end
        end
      end

      match 'home' => 'home#index'

      match 'packages/:group(/:group2(/:group3))' => 'group#show', :as => 'group'
      match 'packages' => 'group#index', :as => 'packages'
      match 'people' => 'home#maintainers_list', :as => 'maintainers'
      match 'rss' => 'rss#index', :as => 'rss'

    end
  end

  match '(/:locale)/misc/bugs' => 'misc#bugs', :locale => SUPPORTED_LOCALES

  match '(/:locale)/security' => 'pages#security', :as => 'security', :locale => SUPPORTED_LOCALES

#  match '/repocop' => 'repocop#index'
#  match '/repocop/by-test/:testname' => 'repocop#bytest'

  match '/repocop/by-test/install_s' => 'repocop#srpms_install_s'

  match '/src\::name' => redirect("/en/Sisyphus/srpms/%{name}"), :name => /[^\/]+/
  match '/:name' => 'redirector#index', :name => /[^\/]+/
end
