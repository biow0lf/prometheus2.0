Given /^I am signed up and confirmed as "(.*)\/(.*)"$/ do |email, password|
  @user = User.create!(:email => email, :password => password, :password_confirmation => password)
  @user.confirmed_at = Time.now
  @user.save!
end
