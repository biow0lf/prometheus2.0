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

    it "should route /security to pages#security" do
      { :get => "/security" }.should route_to(:controller => 'pages',
                                             :action => 'security')
    end

    it "should route /en/security to pages#security" do
      { :get => "/en/security" }.should route_to(:controller => 'pages',
                                                 :action => 'security',
                                                 :locale => 'en')
    end
  end
end