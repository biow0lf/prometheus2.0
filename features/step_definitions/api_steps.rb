# encoding: utf-8

Then /^the JSON response should be:$/ do |string|
  JSON.parse(last_response.body).first.should == JSON.parse(string)
end
