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

    it "should route /Sisyphus/srpms/pmount/patches/pmount-0.9.23-alt-natspec.patch/download to patches#download" do
      { :get => "/Sisyphus/srpms/pmount/patches/pmount-0.9.23-alt-natspec.patch/download" }.should route_to(:controller => 'patches',
                                                                                                            :action => 'download',
                                                                                                            :branch => 'Sisyphus',
                                                                                                            :srpm_id => 'pmount',
                                                                                                            :id => 'pmount-0.9.23-alt-natspec.patch')
    end

    it "should route /en/Sisyphus/srpms/pmount/patches/pmount-0.9.23-alt-natspec.patch/download to patches#download" do
      { :get => "/en/Sisyphus/srpms/pmount/patches/pmount-0.9.23-alt-natspec.patch/download" }.should route_to(:controller => 'patches',
                                                                                                               :action => 'download',
                                                                                                               :branch => 'Sisyphus',
                                                                                                               :srpm_id => 'pmount',
                                                                                                               :id => 'pmount-0.9.23-alt-natspec.patch',
                                                                                                               :locale => 'en')
    end

    it "should route /Sisyphus/srpms/pmount/patches/pmount-0.9.23-alt-natspec.patch to patches#show" do
      { :get => "/Sisyphus/srpms/pmount/patches/pmount-0.9.23-alt-natspec.patch" }.should route_to(:controller => 'patches',
                                                                                                   :action => 'show',
                                                                                                   :branch => 'Sisyphus',
                                                                                                   :srpm_id => 'pmount',
                                                                                                   :id => 'pmount-0.9.23-alt-natspec.patch')
    end

    it "should route /en/Sisyphus/srpms/pmount/patches/pmount-0.9.23-alt-natspec.patch to patches#show" do
      { :get => "/en/Sisyphus/srpms/pmount/patches/pmount-0.9.23-alt-natspec.patch" }.should route_to(:controller => 'patches',
                                                                                                      :action => 'show',
                                                                                                      :branch => 'Sisyphus',
                                                                                                      :srpm_id => 'pmount',
                                                                                                      :id => 'pmount-0.9.23-alt-natspec.patch',
                                                                                                      :locale => 'en')
    end
  end
end
