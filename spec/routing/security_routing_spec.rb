require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SecurityController do
  describe "routing" do
    it "should route /en/Sisyphus/security to security#index" do
      { :get => "/en/Sisyphus/security" }.should route_to(:controller => 'security',
                                                          :action => 'index',
                                                          :branch => 'Sisyphus',
                                                          :locale => 'en')
    end

    it "should route /Sisyphus/security to security#index" do
      { :get => "/Sisyphus/security" }.should route_to(:controller => 'security',
                                                       :action => 'index',
                                                       :branch => 'Sisyphus')
    end
  end
end
