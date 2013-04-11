# encoding: utf-8

Given /^I am signed up and confirmed as "(.*)"$/ do |email|
  password = 'password'
  @user = User.create!(:email => email,
                       :password => password,
                       :password_confirmation => password)
  @user.confirmed_at = Time.zone.now
  @user.save!
end

Given /^I sign in as "(.*)"$/ do |email|
  password = 'password'
  step %{I go to the sign in page}
  step %{I fill in "Email" with "#{email}"}
  step %{I fill in "Password" with "#{password}"}
  step %{I press "Sign in"}
  step %{I should see "Signed in successfully."}
end

Then /^I sign out$/ do
  step %{I go to the home page}
  step %{I follow "Sign out"}
end
