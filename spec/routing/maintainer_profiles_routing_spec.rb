# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MaintainerProfilesController do
  describe "routing" do
    it "should route /maintainer_profile/edit to maintainer_profiles#edit" do
      { :get => "/maintainer_profile/edit" }.should route_to(:controller => 'maintainer_profiles',
                                                             :action => 'edit')
    end

    it "should route /en/maintainer_profile/edit to maintainer_profiles#edit" do
      { :get => "/en/maintainer_profile/edit" }.should route_to(:controller => 'maintainer_profiles',
                                                                :action => 'edit',
                                                                :locale => 'en')
    end

    it "should route PUT /maintainer_profile to maintainer_profiles#update" do
      { :put => "/maintainer_profile" }.should route_to(:controller => 'maintainer_profiles',
                                                        :action => 'update')
    end

    it "should route PUT /en/maintainer_profile to maintainer_profiles#update" do
      { :put => "/en/maintainer_profile" }.should route_to(:controller => 'maintainer_profiles',
                                                           :action => 'update',
                                                           :locale => 'en')
    end
  end
end
