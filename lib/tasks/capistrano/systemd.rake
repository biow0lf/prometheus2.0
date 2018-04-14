# frozen_string_literal: true

namespace :systemd do
  desc 'Stop backend'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute 'sudo systemctl stop prometheus-backend'
      end
    end
  end

  desc 'Start backend'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute 'sudo systemctl start prometheus-backend'
      end
    end
  end

  desc 'Restart backend'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        execute 'sudo systemctl restart prometheus-backend'
      end
    end
  end
end
