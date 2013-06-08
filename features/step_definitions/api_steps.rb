Then(/^the JSON response should be:$/) do |string|
  JSON.parse(last_response.body).should == JSON.parse(string)
end

Given(/^we have acls "(.*?)" for source rpm "(.*?)" in branch "(.*?)"$/) do |logins, package, branch|
  srpm = Srpm.where(name: package).first
  logins.split(',').each do |login|
    srpm.acls << login
  end
end
