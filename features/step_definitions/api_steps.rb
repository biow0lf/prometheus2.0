# encoding: utf-8

Then(/^the JSON response should be:$/) do |string|
  JSON.parse(last_response.body).should == JSON.parse(string)
end

#Given /^the following acls exists:$/ do |table|
#  table.hashes.each do |hash|
#    $redis.sadd("#{hash[:branch]}:#{hash[:package]}:acls", hash[:login])
#  end
#end

Given(/^we have acls "(.*?)" for source rpm "(.*?)" in branch "(.*?)"$/) do |logins, package, branch|
  logins.split(',').each do |login|
    $redis.sadd("#{branch}:#{package}:acls", login)
  end
end
