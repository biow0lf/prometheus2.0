require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RsyncController do
  describe "routing" do
    it "should route /rsync/new to rsync#new" do
      { :get => "/rsync/new" }.should route_to(:controller => 'rsync',
                                               :action => 'new')
    end

    it "should route /en/rsync/new to rsync#new" do
      { :get => "/en/rsync/new" }.should route_to(:controller => 'rsync',
                                                  :action => 'new',
                                                  :locale => 'en')
    end
  end
end
