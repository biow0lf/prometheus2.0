require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MiscController do
  describe "routing" do
    it "should route /misc/bugs to misc#bugs" do
      { :get => "/misc/bugs" }.should route_to(:controller => 'misc',
                                               :action => 'bugs')
    end

    it "should route /en/misc/bugs to misc#bugs" do
      { :get => "/en/misc/bugs" }.should route_to(:controller => 'misc',
                                                  :action => 'bugs',
                                                  :locale => 'en')
    end
  end
end
