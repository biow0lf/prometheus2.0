# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PagesController do
  describe "routing" do
    # TODO?
    # it "should route /project to pages#project" do
    #   { :get => "/project" }.should route_to(:controller => 'pages',
    #                                          :action => 'project')
    # end

    it "should route /en/project to pages#project" do
      { :get => "/en/project" }.should route_to(:controller => 'pages',
                                                :action => 'project',
                                                :locale => 'en')
    end
  end
end