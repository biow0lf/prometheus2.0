# encoding: utf-8

namespace :development do
  task :seed => :environment do
    Branch.create!(:vendor => 'ALT Linux', :name => 'Sisyphus', :order_id => 0)
  end
end

