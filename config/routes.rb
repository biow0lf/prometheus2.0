Prometheus20::Application.routes.draw do
  scope '(:locale)', :locale => SUPPORTED_LOCALES do
    devise_for :users
    resource :maintainer_profile, :only => [:edit, :update]
    resource :search, :only => :show, :id => /[^\/]+/
    root :to => 'home#index'

    get 'm/' => 'iphone#index', :as => 'iphone_home'
    get 'm/maintainer/:login' => 'iphone#maintainer_info', :as => 'iphone_maintainer'
    get 'm/packages/:group(/:group2(/:group3))' => 'iphone#bygroup', :as => 'iphone_group'
  end

  scope ':locale', :locale => SUPPORTED_LOCALES do
    get 'project' => 'pages#project'
    resources :rsync, :controller => :rsync, :only => [:new]
    resources :rebuild, :controller => :rebuild, :only => [:index]

    scope 'Sisyphus' do
      get 'maintainers/:id/gear' => 'maintainers#gear', :as => 'gear_maintainer'
      get 'maintainers/:id/bugs' => 'maintainers#bugs', :as => 'bugs_maintainer'
      get 'maintainers/:id/allbugs' => 'maintainers#allbugs', :as => 'allbugs_maintainer'
      get 'maintainers/:id/ftbfs' => 'maintainers#ftbfs', :as => 'ftbfs_maintainer'
      get 'maintainers/:id/repocop' => 'maintainers#repocop', :as => 'repocop_maintainer'
    end

    scope 'Sisyphus', :id => /[^\/]+/ do
      get 'srpms/:id/bugs' => 'srpms#bugs', :as => 'bugs_srpm'
      get 'srpms/:id/allbugs' => 'srpms#allbugs', :as => 'allbugs_srpm'
      get 'srpms/:id/repocop' => 'srpms#repocop', :as => 'repocop_srpm'
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
          get 'gear'
        end
        resources :patches, :only => [:index, :show]
        resources :sources, :only => :index do
          get 'download', :on => :member
        end
      end

      get 'home' => 'home#index'

      get 'packages/:group(/:group2(/:group3))' => 'group#show', :as => 'group'
      get 'packages' => 'group#index', :as => 'packages'
      get 'people' => 'home#maintainers_list', :as => 'maintainers'
      get 'rss' => 'rss#index', :as => 'rss'
    end
  end

  get '(/:locale)/misc/bugs' => 'misc#bugs', :locale => SUPPORTED_LOCALES

# TODO: spec this
  get '(/:locale)/:branch/security' => 'security#index', :as => 'security', :locale => SUPPORTED_LOCALES
# END

#  get '/repocop' => 'repocop#index'
#  get '/repocop/by-test/:testname' => 'repocop#bytest'

  get '/repocop/by-test/install_s' => 'repocop#srpms_install_s'

  get '/src\::name' => redirect("/en/Sisyphus/srpms/%{name}"), :name => /[^\/]+/
  get '/:name' => 'redirector#index', :name => /[^\/]+/
end
