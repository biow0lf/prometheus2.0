namespace :sisyphus do
  namespace :expire do
    desc "Expire home#index aka /,/{:locale} pages"
    task :home_index => :environment do
      puts Time.now.to_s + ": Expire home#index aka /,/{:locale} pages"
      
      ActionController::Base.expire_page(:controller => 'home', :action => 'index', :locale => '')
      ActionController::Base.expire_page(:controller => 'home', :action => 'index', :locale => '/en')
      ActionController::Base.expire_page(:controller => 'home', :action => 'index', :locale => '/ru')
      ActionController::Base.expire_page(:controller => 'home', :action => 'index', :locale => '/uk')
      ActionController::Base.expire_page(:controller => 'home', :action => 'index', :locale => '/br')
      
      puts Time.now.to_s + ": done"
    end
  end
end