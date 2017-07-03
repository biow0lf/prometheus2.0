RSpec.configure do |config|
  config.before(:suite) do
    DatabaseRewinder.clean_all
  end

  config.before(:each) do
    DatabaseRewinder.clean
  end
end
