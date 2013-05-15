require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RedirectorController do
  describe "routing" do
    it "should route /glibc to redirector#index" do
      { :get => "/glibc" }.should route_to(:controller => 'redirector', :action => 'index', :name => 'glibc')
    end

    # it "should route /src:glibc" do
    #   { :get => "/src:glibc" }.should route_to(:controller => 'redirector', :action => 'index', :name => 'glibc')
    # end
  end
end

# match '/src\::name' => redirect("/en/Sisyphus/srpms/%{name}"), :name => /[^\/]+/
