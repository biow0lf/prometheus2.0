# encoding: utf-8

Then /^the JSON response should be:$/ do |string|
  JSON.parse(last_response.body).should == JSON.parse(string)
end

Given /^the following acls exists:$/ do |table|
  table.hashes.each do |hash|
    $redis.sadd("#{hash[:branch]}:#{hash[:package]}:acls", hash[:login])
  end
end
