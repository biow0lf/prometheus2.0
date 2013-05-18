require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MaintainersController do
  describe "routing" do
    it "should route /Sisyphus/maintainers/icesik to maintainers#show" do
      { :get => "/Sisyphus/maintainers/icesik" }.should route_to(:controller => 'maintainers',
                                                                 :action => 'show',
                                                                 :branch => 'Sisyphus',
                                                                 :id => 'icesik')
    end

    it "should route /en/Sisyphus/maintainers/icesik to maintainers#show" do
      { :get => "/en/Sisyphus/maintainers/icesik" }.should route_to(:controller => 'maintainers',
                                                                    :action => 'show',
                                                                    :branch => 'Sisyphus',
                                                                    :id => 'icesik',
                                                                    :locale => 'en')
    end

    it "should route /Sisyphus/maintainers/icesik/srpms to maintainers#srpms" do
      { :get => "/Sisyphus/maintainers/icesik/srpms" }.should route_to(:controller => 'maintainers',
                                                                       :action => 'srpms',
                                                                       :branch => 'Sisyphus',
                                                                       :id => 'icesik')
    end

    it "should route /en/Sisyphus/maintainers/icesik/srpms to maintainers#srpms" do
      { :get => "/en/Sisyphus/maintainers/icesik/srpms" }.should route_to(:controller => 'maintainers',
                                                                          :action => 'srpms',
                                                                          :branch => 'Sisyphus',
                                                                          :id => 'icesik',
                                                                          :locale => 'en')
    end

    it "should route /Sisyphus/maintainers/icesik/gear to maintainers#gear" do
      { :get => "/Sisyphus/maintainers/icesik/gear" }.should route_to(:controller => 'maintainers',
                                                                      :action => 'gear',
                                                                      :id => 'icesik')
    end

    it "should route /en/Sisyphus/maintainers/icesik/gear to maintainers#gear" do
      { :get => "/en/Sisyphus/maintainers/icesik/gear" }.should route_to(:controller => 'maintainers',
                                                                         :action => 'gear',
                                                                         :id => 'icesik',
                                                                         :locale => 'en')
    end

    it "should route /Sisyphus/maintainers/icesik/bugs to maintainers#bugs" do
      { :get => "/Sisyphus/maintainers/icesik/bugs" }.should route_to(:controller => 'maintainers',
                                                                      :action => 'bugs',
                                                                      :id => 'icesik')
    end

    it "should route /en/Sisyphus/maintainers/icesik/bugs to maintainers#bugs" do
      { :get => "/en/Sisyphus/maintainers/icesik/bugs" }.should route_to(:controller => 'maintainers',
                                                                         :action => 'bugs',
                                                                         :id => 'icesik',
                                                                         :locale => 'en')
    end

    it "should route /Sisyphus/maintainers/icesik/allbugs to maintainers#allbugs" do
      { :get => "/Sisyphus/maintainers/icesik/allbugs" }.should route_to(:controller => 'maintainers',
                                                                         :action => 'allbugs',
                                                                         :id => 'icesik')
    end

    it "should route /en/Sisyphus/maintainers/icesik/allbugs to maintainers#allbugs" do
      { :get => "/en/Sisyphus/maintainers/icesik/allbugs" }.should route_to(:controller => 'maintainers',
                                                                            :action => 'allbugs',
                                                                            :id => 'icesik',
                                                                            :locale => 'en')
    end

    it "should route /Sisyphus/maintainers/icesik/ftbfs to maintainers#ftbfs" do
      { :get => "/Sisyphus/maintainers/icesik/ftbfs" }.should route_to(:controller => 'maintainers',
                                                                       :action => 'ftbfs',
                                                                       :id => 'icesik')
    end

    it "should route /en/Sisyphus/maintainers/icesik/ftbfs to maintainers#ftbfs" do
      { :get => "/en/Sisyphus/maintainers/icesik/ftbfs" }.should route_to(:controller => 'maintainers',
                                                                          :action => 'ftbfs',
                                                                          :id => 'icesik',
                                                                          :locale => 'en')
    end

    it "should route /Sisyphus/maintainers/icesik/repocop to maintainers#repocop" do
      { :get => "/Sisyphus/maintainers/icesik/repocop" }.should route_to(:controller => 'maintainers',
                                                                         :action => 'repocop',
                                                                         :id => 'icesik')
    end

    it "should route /en/Sisyphus/maintainers/icesik/repocop to maintainers#repocop" do
      { :get => "/en/Sisyphus/maintainers/icesik/repocop" }.should route_to(:controller => 'maintainers',
                                                                            :action => 'repocop',
                                                                            :id => 'icesik',
                                                                            :locale => 'en')
    end
  end
end
