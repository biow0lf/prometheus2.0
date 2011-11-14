# encoding: utf-8

Given /^I am signed up and confirmed as "(.*)"$/ do |email|
  password = 'password'
  @user = User.create!(:email => email, :password => password, :password_confirmation => password)
  @user.confirmed_at = Time.zone.now
  @user.save!
end

Given /^I sign in as "(.*)"$/ do |email|
  password = 'password'
  Given %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign in"}
  Then %{I should see "Signed in successfully."}
end

Then /^I sign out$/ do
  And %{I go to the home page}
  And %{I follow "Sign out"}
end
