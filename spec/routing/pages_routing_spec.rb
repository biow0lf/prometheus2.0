require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PagesController, :type => :routing do
  describe "routing" do
    it "should route /project to pages#project" do
      expect({ :get => "/project" }).to route_to(:controller => 'pages',
                                             :action => 'project')
    end

    it "should route /en/project to pages#project" do
      expect({ :get => "/en/project" }).to route_to(:controller => 'pages',
                                                :action => 'project',
                                                :locale => 'en')
    end
  end
end