Then /^a confirmation message should be sent to "([^"]*)"$/ do |arg1|
  pending
end

# Then /^a confirmation message should be sent to "(.*)"$/ do |email|
#   user = User.find_by_email(email)
#   sent = ActionMailer::Base.deliveries.last
#   assert_equal [user.email], sent.to
#   assert_match /confirm/i, sent.subject
#   assert !user.confirmation_token.blank?
#   assert_match /#{user.confirmation_token}/, sent.body
# end

Then /^I should confirm my email "([^"]*)"$/ do |email|
  user = User.find_by_email(email)
  user.confirmed_at = Time.now
  user.save!
end
