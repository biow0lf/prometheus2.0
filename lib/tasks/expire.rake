namespace :sisyphus do
  namespace :expire do
    desc "Expire home#index aka /,/{:locale} pages"
    task :home_index => :environment do
      puts Time.now.to_s + ": Expire home#index aka /,/{:locale} pages"
      
      ActionController::Base.expire_page('/')
      ActionController::Base.expire_page('/en')
      ActionController::Base.expire_page('/ru')
      ActionController::Base.expire_page('/uk')
      ActionController::Base.expire_page('/br')
      
      puts Time.now.to_s + ": done"
    end
  end
end