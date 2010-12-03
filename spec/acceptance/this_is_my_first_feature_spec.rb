require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "This Is My First Feature", %q{
  In order to test steak
  As a Developer
  I want to wrote test steak spec
} do

  scenario "Scenario name" do
    p Capybara.javascript_driver
    true.should == true
  end
end
