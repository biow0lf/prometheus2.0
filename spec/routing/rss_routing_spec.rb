# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RssController do
  describe "routing" do
    # TODO?
    # it "should route /Sisyphus/rss to rss#index" do
    #   { :get => "/Sisyphus/rss" }.should route_to(:controller => 'rss',
    #                                               :action => 'index',
    #                                               :branch => 'Sisyphus')
    # end

    it "should route /en/Sisyphus/rss to rss#index" do
      { :get => "/en/Sisyphus/rss" }.should route_to(:controller => 'rss',
                                                     :action => 'index',
                                                     :branch => 'Sisyphus',
                                                     :locale => 'en')
    end
  end
end