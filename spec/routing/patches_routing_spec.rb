require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PatchesController do
  describe "routing" do
    it "should route /Sisyphus/srpms/glibc/patches to patches#index" do
      { :get => "/Sisyphus/srpms/glibc/patches" }.should route_to(:controller => 'patches',
                                                                  :action => 'index',
                                                                  :branch => 'Sisyphus',
                                                                  :srpm_id => 'glibc')
    end

    it "should route /en/Sisyphus/srpms/glibc/patches to patches#index" do
      { :get => "/en/Sisyphus/srpms/glibc/patches" }.should route_to(:controller => 'patches',
                                                                     :action => 'index',
                                                                     :branch => 'Sisyphus',
                                                                     :srpm_id => 'glibc',
                                                                     :locale => 'en')
    end
  end
end
