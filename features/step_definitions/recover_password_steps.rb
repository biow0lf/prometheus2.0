Given /^I am signed up and confirmed as "([^"]*)" with unknown password$/ do |email|
  password = ActiveSupport::SecureRandom.hex(16)
  @user = User.create!(:email => email, :password => password, :password_confirmation => password)
  @user.confirmed_at = Time.now
  @user.save!
end
