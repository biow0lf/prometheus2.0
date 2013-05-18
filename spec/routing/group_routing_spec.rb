require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GroupController do
  describe "routing" do
    it "should route /Sisyphus/packages to group#index" do
      { :get => "/Sisyphus/packages" }.should route_to(:controller => 'group',
                                                       :action => 'index',
                                                       :branch => 'Sisyphus')
    end

    it "should route /en/Sisyphus/packages to group#index" do
      { :get => "/en/Sisyphus/packages" }.should route_to(:controller => 'group',
                                                          :action => 'index',
                                                          :locale => 'en',
                                                          :branch => 'Sisyphus')
    end

    it "should route /Sisyphus/packages/Accessibility to group#bygroup" do
      { :get => "/Sisyphus/packages/Accessibility" }.should route_to(:controller => 'group',
                                                                     :action => 'show',
                                                                     :branch => 'Sisyphus',
                                                                     :group => 'Accessibility')
    end

    it "should route /en/Sisyphus/packages/Accessibility to group#bygroup" do
      { :get => "/en/Sisyphus/packages/Accessibility" }.should route_to(:controller => 'group',
                                                                        :action => 'show',
                                                                        :locale => 'en',
                                                                        :branch => 'Sisyphus',
                                                                        :group => 'Accessibility')
    end

    it "should route /Sisyphus/packages/Archiving/Compression to group#bygroup" do
      { :get => "/Sisyphus/packages/Archiving/Compression" }.should route_to(:controller => 'group',
                                                                             :action => 'show',
                                                                             :branch => 'Sisyphus',
                                                                             :group => 'Archiving',
                                                                             :group2 => 'Compression')
    end

    it "should route /en/Sisyphus/packages/Archiving/Compression to group#bygroup" do
      { :get => "/en/Sisyphus/packages/Archiving/Compression" }.should route_to(:controller => 'group',
                                                                                :action => 'show',
                                                                                :locale => 'en',
                                                                                :branch => 'Sisyphus',
                                                                                :group => 'Archiving',
                                                                                :group2 => 'Compression')
    end

    it "should route /Sisyphus/packages/System/Configuration/Hardware to group#bygroup" do
      { :get => "/Sisyphus/packages/System/Configuration/Hardware" }.should route_to(:controller => 'group',
                                                                                     :action => 'show',
                                                                                     :branch => 'Sisyphus',
                                                                                     :group => 'System',
                                                                                     :group2 => 'Configuration',
                                                                                     :group3 => 'Hardware')
    end

    it "should route /en/Sisyphus/packages/System/Configuration/Hardware to group#bygroup" do
      { :get => "/en/Sisyphus/packages/System/Configuration/Hardware" }.should route_to(:controller => 'group',
                                                                                        :action => 'show',
                                                                                        :locale => 'en',
                                                                                        :branch => 'Sisyphus',
                                                                                        :group => 'System',
                                                                                        :group2 => 'Configuration',
                                                                                        :group3 => 'Hardware')
    end
  end
end
