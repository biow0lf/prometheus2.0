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

    it "should route /en/Sisyphus/security?page=2 to security#index" do
      { :get => "/en/Sisyphus/security?page=2" }.should route_to(:controller => 'security',
                                                                 :action => 'index',
                                                                 :branch => 'Sisyphus',
                                                                 :locale => 'en',
                                                                 :page   => '2')
    end

    it "should route /Sisyphus/security?page=2 to security#index" do
      { :get => "/Sisyphus/security?page=2" }.should route_to(:controller => 'security',
                                                              :action => 'index',
                                                              :branch => 'Sisyphus',
                                                              :page   => '2')
    end
  end
end
