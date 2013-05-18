require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RebuildController do
  describe "routing" do
    it "should route /rebuild to rebuild#index" do
      { :get => "/rebuild" }.should route_to(:controller => 'rebuild',
                                             :action => 'index')
    end

    it "should route /en/rebuild to rebuild#index" do
      { :get => "/en/rebuild" }.should route_to(:controller => 'rebuild',
                                                :action => 'index',
                                                :locale => 'en')
    end
  end
end
