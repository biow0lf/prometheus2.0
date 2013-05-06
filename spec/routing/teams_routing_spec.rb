require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TeamsController do
  describe "routing" do
    # TODO?
    # it "should route /Sisyphus/teams/ruby to teams#show" do
    #   { :get => "/Sisyphus/teams/ruby" }.should route_to(:controller => 'teams',
    #                                                      :action => 'show',
    #                                                      :branch => 'Sisyphus',
    #                                                      :id => 'ruby')
    # end

    it "should route /en/Sisyphus/teams/ruby to teams#show" do
      { :get => "/en/Sisyphus/teams/ruby" }.should route_to(:controller => 'teams',
                                                            :action => 'show',
                                                            :branch => 'Sisyphus',
                                                            :id => 'ruby',
                                                            :locale => 'en')
    end
  end
end