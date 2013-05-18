require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SourcesController do
  describe "routing" do
    it "should route /Sisyphus/srpms/glibc/sources to sources#index" do
      { :get => "/Sisyphus/srpms/glibc/sources" }.should route_to(:controller => 'sources',
                                                                  :action => 'index',
                                                                  :branch => 'Sisyphus',
                                                                  :srpm_id => 'glibc')
    end

    it "should route /en/Sisyphus/srpms/glibc/sources to sources#index" do
      { :get => "/en/Sisyphus/srpms/glibc/sources" }.should route_to(:controller => 'sources',
                                                                     :action => 'index',
                                                                     :branch => 'Sisyphus',
                                                                     :srpm_id => 'glibc',
                                                                     :locale => 'en')
    end

    it "should route /Sisyphus/srpms/glibc/sources/glibc-2.16-alt4.tar/download to sources#download" do
      { :get => "/Sisyphus/srpms/glibc/sources/glibc-2.16-alt4.tar/download" }.should route_to(:controller => 'sources',
                                                                                               :action => 'download',
                                                                                               :branch => 'Sisyphus',
                                                                                               :srpm_id => 'glibc',
                                                                                               :id => 'glibc-2.16-alt4.tar')
    end

    it "should route /en/Sisyphus/srpms/glibc/sources/glibc-2.16-alt4.tar/download to sources#download" do
      { :get => "/en/Sisyphus/srpms/glibc/sources/glibc-2.16-alt4.tar/download" }.should route_to(:controller => 'sources',
                                                                                                  :action => 'download',
                                                                                                  :branch => 'Sisyphus',
                                                                                                  :srpm_id => 'glibc',
                                                                                                  :id => 'glibc-2.16-alt4.tar',
                                                                                                  :locale => 'en')
    end
  end
end
