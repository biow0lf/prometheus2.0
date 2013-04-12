if Rails.env.test?
  Capybara.configure do |config|
    config.ignore_hidden_elements = false
  end
end

