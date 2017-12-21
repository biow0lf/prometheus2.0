# frozen_string_literal: true

namespace :clear do
  desc 'Clear all cache'
  task cache: :environment do
    puts "#{ Time.zone.now }: Clear cache"

    puts "#{ Time.zone.now }: end"
  end
end
