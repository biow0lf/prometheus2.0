# encoding: utf-8

When(/^I visit "(.*)"$/) do |url|
  header 'Accept', 'application/json'
  get url
  # puts last_response.body
end
