# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  authenticate :user, ->(user) { user.admin? } do
    mount PgHero::Engine, at: 'pghero'
  end

  namespace :api, defaults: { format: 'json' } do
    resources :docs, only: :index

    resources :branches, only: [:index, :show]

    resources :bugs, only: :show

    resources :srpms, id: /[^\/]+/, only: [:index, :show] do
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
      get 'srpms/:id/bugs' => 'srpm_opened_bugs#index', id: /[^\/]+/, branch: /Sisyphus/, as: 'bugs_srpm'
      get 'srpms/:id/allbugs' => 'srpm_all_bugs#index', id: /[^\/]+/, branch: /Sisyphus/, as: 'allbugs_srpm'
      get 'srpms/:id/repocop' => 'srpm_repocops#index', id: /[^\/]+/, branch: /Sisyphus/, as: 'repocop_srpm'

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

      get 'srpms/:id/:version' => 'srpms#show', id: /[^\/]+/, version: /[^\/]+/, as: 'versioned_srpm'
      get 'srpms/:id/:version/changelog' => 'srpms#changelog', id: /[^\/]+/, version: /[^\/]+/, as: 'versioned_changelog_srpm'
      get 'srpms/:id/:version/spec' => 'srpms#spec', id: /[^\/]+/, version: /[^\/]+/, as: 'versioned_spec_srpm'
      get 'srpms/:id/:version/rawspec' => 'srpms#rawspec', id: /[^\/]+/, version: /[^\/]+/, as: 'versioned_rawspec_srpm'
      get 'srpms/:id/:version/get' => 'srpms#get', id: /[^\/]+/, version: /[^\/]+/, as: 'versioned_get_srpm'
      get 'srpms/:id/:version/gear' => 'srpms#gear', id: /[^\/]+/, version: /[^\/]+/, as: 'versioned_gear_srpm'
      get 'patches/:srpm_id/:version/index' => 'patches#index', srpm_id: /[^\/]+/, version: /[^\/]+/, as: 'versioned_srpm_patches'
      get 'patches/:srpm_id/:version/show' => 'patches#show', srpm_id: /[^\/]+/, version: /[^\/]+/, as: 'versioned_srpm_patch'
      get 'patches/:srpm_id/:version/download' => 'patches#download', srpm_id: /[^\/]+/, version: /[^\/]+/, as: 'versioned_srpm_patch_download'
      get 'sources/:srpm_id/:version/index' => 'sources#index', srpm_id: /[^\/]+/, version: /[^\/]+/, as: 'versioned_srpm_sources'
      get 'sources/:srpm_id/:version/download' => 'sources#download', srpm_id: /[^\/]+/, version: /[^\/]+/, as: 'versioned_srpm_source_download'
      get 'srpms/:id/:version/bugs' => 'srpm_opened_bugs#index', id: /[^\/]+/, version: /[^\/]+/, branch: /Sisyphus/, as: 'versioned_bugs_srpm'
      get 'srpms/:id/:version/allbugs' => 'srpm_all_bugs#index',  id: /[^\/]+/, version: /[^\/]+/, branch: /Sisyphus/, as: 'versioned_allbugs_srpm'
      get 'srpms/:id/:version/repocop' => 'srpm_repocops#index',  id: /[^\/]+/, version: /[^\/]+/, branch: /Sisyphus/, as: 'versioned_repocop_srpm'

      get 'rss' => 'rss#index', as: 'rss'
      resources :teams, only: [:index, :show]

      resources :maintainers, only: :index

      get 'packages/:group(/:group2(/:group3))' => 'group#show', as: 'group'
      get 'packages' => 'group#index', as: 'packages'
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

  get '/src::name' => 'srpm_redirector#index', name: /[^\/]+/

  get '/:name' => 'redirector#index', name: /[^\/]+/
end
