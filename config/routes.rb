Rails.application.routes.draw do
  namespace :admin do
    resources :branches
resources :srpms
resources :users
resources :bugs
resources :changelogs
resources :maintainers
resources :packages
resources :conflicts
resources :freshmeats
resources :gears
resources :groups
resources :maintainer_teams
resources :mirrors
resources :obsoletes
resources :patches
resources :perl_watches
resources :provides
resources :repocops
resources :repocop_patches
resources :requires
resources :sources
resources :specfiles
resources :teams

    root to: "branches#index"
  end

  namespace :api, defaults: { format: 'json' } do
    resources :docs, only: :index

    resources :branches, only: [:index, :show]

    resources :bugs, only: :show

    resources :srpms, id: /[^\/]+/, only: :show do
      resources :packages, id: /[^\/]+/, only: :index

      resources :changelogs, id: /[^\/]+/, only: :index
    end

    resources :packages, id: /[^\/]+/, only: :show, controller: :package

    resources :maintainers, only: [:index, :show]
  end

  scope '(:locale)', locale: SUPPORTED_LOCALES do
    devise_for :users

    root to: 'home#index'

    get 'project' => 'pages#project'

    scope '(:branch)', branch: SUPPORTED_BRANCHES do
      resources :srpms, id: /[^\/]+/, only: :show do
        member do
          get 'changelog'
          get 'spec'
          get 'rawspec'
          get 'get'
          get 'gear'
        end

        resources :patches, only: [:index, :show] do
          resource :download, only: :show, controller: :patch_download
        end

        resources :sources, only: :index do
          resource :download, only: :show, controller: :source_download
        end
      end

      get 'rss' => 'rss#index', as: 'rss'
      resources :teams, only: :show
      get 'people' => 'home#maintainers_list', as: 'maintainers'
      get 'packages/:group(/:group2(/:group3))' => 'group#show', as: 'group'
      get 'packages' => 'group#index', as: 'packages'
    end

    scope 'Sisyphus', id: /[^\/]+/ do
      get 'srpms/:id/bugs' => 'srpms#bugs', as: 'bugs_srpm'
      get 'srpms/:id/allbugs' => 'srpms#allbugs', as: 'allbugs_srpm'
      get 'srpms/:id/repocop' => 'srpms#repocop', as: 'repocop_srpm'
    end

    resource :maintainer_profile, only: [:edit, :update]
    resource :search, only: :show, id: /[^\/]+/
    resources :rebuild, controller: :rebuild, only: :index
    resources :rsync, controller: :rsync, only: :new

    scope ':branch', branch: SUPPORTED_BRANCHES do
      resources :maintainers, only: :show do
        get 'srpms', on: :member
        resources :activity, only: :index, controller: :maintainer_activity
      end
    end

    scope 'Sisyphus' do
      get 'maintainers/:id/gear' => 'maintainers#gear', as: 'gear_maintainer'
      get 'maintainers/:id/bugs' => 'maintainers#bugs', as: 'bugs_maintainer'
      get 'maintainers/:id/allbugs' => 'maintainers#allbugs', as: 'allbugs_maintainer'
      get 'maintainers/:id/ftbfs' => 'maintainers#ftbfs', as: 'ftbfs_maintainer'
      get 'maintainers/:id/repocop' => 'maintainers#repocop', as: 'repocop_maintainer'
    end
  end

  scope ':locale', locale: SUPPORTED_LOCALES do
    scope ':branch', branch: SUPPORTED_BRANCHES do
      get 'home' => 'home#index'
    end
  end

  get '(/:locale)/misc/bugs' => 'misc#bugs', locale: SUPPORTED_LOCALES

  get '(/:locale)/:branch/security' => 'security#index', as: 'security',
                                                         locale: SUPPORTED_LOCALES,
                                                         branch: SUPPORTED_BRANCHES

  # TODO: drop this later
  # get '/repocop' => 'repocop#index'
  # get '/repocop/by-test/:testname' => 'repocop#bytest'
  #
  # get '/repocop/by-test/install_s' => 'repocop#srpms_install_s'

  # TODO: drop this and make API
  get '/repocop/no_url_tag' => 'repocop#no_url_tag'
  get '/repocop/invalid_url' => 'repocop#invalid_url'
  get '/repocop/invalid_vendor' => 'repocop#invalid_vendor'
  get '/repocop/invalid_distribution' => 'repocop#invalid_distribution'
  get '/repocop/srpms_summary_too_long' => 'repocop#srpms_summary_too_long'
  get '/repocop/packages_summary_too_long' => 'repocop#packages_summary_too_long'
  get '/repocop/srpms_summary_ended_with_dot' => 'repocop#srpms_summary_ended_with_dot'
  get '/repocop/packages_summary_ended_with_dot' => 'repocop#packages_summary_ended_with_dot'
  get '/repocop/srpms_filename_too_long_for_joliet' => 'repocop#srpms_filename_too_long_for_joliet'
  get '/repocop/packages_filename_too_long_for_joliet' => 'repocop#packages_filename_too_long_for_joliet'
  get '/repocop/srpms_install_s' => 'repocop#srpms_install_s'
  # END

  get '/src\::name' => redirect('/en/Sisyphus/srpms/%{name}'), name: /[^\/]+/
  get '/:name' => 'redirector#index', name: /[^\/]+/
end
