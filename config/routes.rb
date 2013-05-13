Prometheus20::Application.routes.draw do
# TODO: add specs for this
  scope 'api' do
    scope 'v1' do
      scope ':branch', :branch => /[^\/]+/ do
#        resources :srpm, :id => /[^\/]+/, :only => :show do
#          member do
#            get 'changelog'
#          end
#        end

        get 'srpms' => 'api/v1/srpms#srpms_list', :as => nil

        scope 'srpms' do
          scope ':id', :id => /[^\/]+/ do
            get '/' => 'api/v1/srpms#show', :as => nil
            get 'changelog' => 'api/v1/srpms#changelog', :as => nil
            get 'gear' => 'api/v1/srpms#gear', :as => nil
            get 'bugs' => 'api/v1/srpms#bugs', :as => nil
            get 'allbugs' => 'api/v1/srpms#allbugs', :as => nil
            get 'repocop' => 'api/v1/srpms#repocop', :as => nil
          end
        end

        scope 'repocop' do
          get '/' => 'api/v1/repocop#index', :as => nil
          get ':testname' => 'api/v1/repocop#show', :as => nil
        end

        scope 'people' do
          get '/' => 'api/v1/maintainers#index', :as => nil
          scope ':login' do
            get '/' => 'api/v1/maintainers#show', :as => nil
            get 'srpms' => 'api/v1/maintainers#srpms', :as => nil
            get 'gear' => 'api/v1/maintainers#gear', :as => nil
          end
        end
# END

#        resources :srpms, :id => /[^\/]+/, :only => :show, :as => 'api_v1_srpm_show' do
#          member do
#            get 'changelog'
#            get 'spec'
#            get 'rawspec'
#            get 'get'
#            get 'gear'
#          end
#          resources :patches, :only => [:index, :show]
#          resources :sources, :only => :index do
#            get 'download', :on => :member
#          end
#        end
      end
    end
  end

  scope '(:locale)', :locale => SUPPORTED_LOCALES do
    devise_for :users
    get 'project' => 'pages#project'
    resource :maintainer_profile, :only => [:edit, :update]
    resource :search, :only => :show, :id => /[^\/]+/
    root :to => 'home#index'

    get 'm/' => 'iphone#index', :as => 'iphone_home'
    get 'm/maintainer/:login' => 'iphone#maintainer_info', :as => 'iphone_maintainer'
    get 'm/packages/:group(/:group2(/:group3))' => 'iphone#bygroup', :as => 'iphone_group'
  end

  scope ':locale', :locale => SUPPORTED_LOCALES do
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

# TODO: drop this for API
#  get '/repocop' => 'repocop#index'
#  get '/repocop/by-test/:testname' => 'repocop#bytest'
  get '/repocop/by-test/no_url_tag' => 'repocop#no_url_tag'
  get '/repocop/by-test/invalid_url' => 'repocop#invalid_url'
  get '/repocop/by-test/invalid_vendor' => 'repocop#invalid_vendor'
  get '/repocop/by-test/invalid_distribution' => 'repocop#invalid_distribution'
  get '/repocop/by-test/srpms_summary_too_long' => 'repocop#srpms_summary_too_long'
  get '/repocop/by-test/packages_summary_too_long' => 'repocop#packages_summary_too_long'
  get '/repocop/by-test/srpms_summary_ended_with_dot' => 'repocop#srpms_summary_ended_with_dot'
  get '/repocop/by-test/packages_summary_ended_with_dot' => 'repocop#packages_summary_ended_with_dot'
  get '/repocop/by-test/srpms_filename_too_long_for_joliet' => 'repocop#srpms_filename_too_long_for_joliet'
  get '/repocop/by-test/packages_filename_too_long_for_joliet' => 'repocop#packages_filename_too_long_for_joliet'
  get '/repocop/by-test/srpms_install_s' => 'repocop#srpms_install_s'
# END

  get '/src\::name' => redirect("/en/Sisyphus/srpms/%{name}"), :name => /[^\/]+/
  get '/:name' => 'redirector#index', :name => /[^\/]+/
end
