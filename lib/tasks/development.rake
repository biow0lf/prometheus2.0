namespace :development do
  task seed: :environment do
    Branch.create!(name: 'Sisyphus', order_id: 0)
  end
end
