# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController do
  describe "routing" do
    it "should route / to home#index" do
      { :get => "/" }.should route_to(:controller => 'home',
                                      :action => 'index')
    end

    it "should route /en to home#index" do
      { :get => "/en" }.should route_to(:controller => 'home',
                                        :action => 'index',
                                        :locale => 'en')
    end

    it "should route /en/Sisyphus/home to home#index" do
      { :get => "/en/Sisyphus/home" }.should route_to(:controller => 'home',
                                                      :action => 'index',
                                                      :branch => 'Sisyphus',
                                                      :locale => 'en')
    end

    # TODO?
    # it "should route /Sisyphus/people to home#maintainers_list" do
    #   { :get => "/Sisyphus/people" }.should route_to(:controller => 'home',
    #                                                  :action => 'maintainers_list',
    #                                                  :branch => 'Sisyphus')
    # end

    it "should route /en/Sisyphus/people to home#maintainers_list" do
      { :get => "/en/Sisyphus/people" }.should route_to(:controller => 'home',
                                                        :action => 'maintainers_list',
                                                        :branch => 'Sisyphus',
                                                        :locale => 'en')
    end
  end
end
