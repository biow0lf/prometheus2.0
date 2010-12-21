Given /^I am logged in with "(.*)\/(.*)"$/ do |email, password|
  Given %{I go to the sign in page} 
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign in"}
  Then %{I should see "Signed in successfully."}
end
