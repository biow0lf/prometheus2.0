# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SrpmsController do
  describe "routing" do
    # TODO?
    # it "should route /Sisyphus/srpms/glibc to srpms#show" do
    #   { :get => "/Sisyphus/srpms/glibc" }.should route_to(:controller => 'srpms',
    #                                                       :action => 'show',
    #                                                       :branch => 'Sisyphus',
    #                                                       :id => 'glibc')
    # end

    it "should route /en/Sisyphus/srpms/glibc to srpms#show" do
      { :get => "/en/Sisyphus/srpms/glibc" }.should route_to(:controller => 'srpms',
                                                             :action => 'show',
                                                             :branch => 'Sisyphus',
                                                             :id => 'glibc',
                                                             :locale => 'en')
    end

    # TODO?
    # it "should route /Sisyphus/srpms/glibc/changelog to srpms#show" do
    #   { :get => "/Sisyphus/srpms/glibc/changelog" }.should route_to(:controller => 'srpms',
    #                                                                 :action => 'changelog',
    #                                                                 :branch => 'Sisyphus',
    #                                                                 :id => 'glibc')
    # end

    it "should route /en/Sisyphus/srpms/glibc/changelog to srpms#changelog" do
      { :get => "/en/Sisyphus/srpms/glibc/changelog" }.should route_to(:controller => 'srpms',
                                                                       :action => 'changelog',
                                                                       :branch => 'Sisyphus',
                                                                       :id => 'glibc',
                                                                       :locale => 'en')
    end

    # TODO?
    # it "should route /Sisyphus/srpms/glibc/spec to srpms#spec" do
    #   { :get => "/Sisyphus/srpms/glibc/spec" }.should route_to(:controller => 'srpms',
    #                                                            :action => 'spec',
    #                                                            :branch => 'Sisyphus',
    #                                                            :id => 'glibc')
    # end

    it "should route /en/Sisyphus/srpms/glibc/spec to srpms#spec" do
      { :get => "/en/Sisyphus/srpms/glibc/spec" }.should route_to(:controller => 'srpms',
                                                                  :action => 'spec',
                                                                  :branch => 'Sisyphus',
                                                                  :id => 'glibc',
                                                                  :locale => 'en')
    end

    # TODO?
    # it "should route /Sisyphus/srpms/glibc/rawspec to srpms#rawspec" do
    #   { :get => "/Sisyphus/srpms/glibc/rawspec" }.should route_to(:controller => 'srpms',
    #                                                               :action => 'rawspec',
    #                                                               :branch => 'Sisyphus',
    #                                                               :id => 'glibc')
    # end

    it "should route /en/Sisyphus/srpms/glibc/rawspec to srpms#rawspec" do
      { :get => "/en/Sisyphus/srpms/glibc/rawspec" }.should route_to(:controller => 'srpms',
                                                                     :action => 'rawspec',
                                                                     :branch => 'Sisyphus',
                                                                     :id => 'glibc',
                                                                     :locale => 'en')
    end

    # TODO?
    # it "should route /Sisyphus/srpms/glibc/get to srpms#get" do
    #   { :get => "/Sisyphus/srpms/glibc/get" }.should route_to(:controller => 'srpms',
    #                                                            :action => 'get',
    #                                                            :branch => 'Sisyphus',
    #                                                            :id => 'glibc')
    # end

    it "should route /en/Sisyphus/srpms/glibc/get to srpms#spec" do
      { :get => "/en/Sisyphus/srpms/glibc/get" }.should route_to(:controller => 'srpms',
                                                                 :action => 'get',
                                                                 :branch => 'Sisyphus',
                                                                 :id => 'glibc',
                                                                 :locale => 'en')
    end

    # TODO?
    # it "should route /Sisyphus/srpms/glibc/gear to srpms#gear" do
    #   { :get => "/Sisyphus/srpms/glibc/gear" }.should route_to(:controller => 'srpms',
    #                                                            :action => 'gear',
    #                                                            :id => 'glibc')
    # end

    it "should route /en/Sisyphus/srpms/glibc/gear to srpms#gear" do
      { :get => "/en/Sisyphus/srpms/glibc/gear" }.should route_to(:controller => 'srpms',
                                                                  :action => 'gear',
                                                                  :branch => 'Sisyphus',
                                                                  :id => 'glibc',
                                                                  :locale => 'en')
    end

    # TODO?
    # it "should route /Sisyphus/srpms/glibc/bugs to srpms#bugs" do
    #   { :get => "/Sisyphus/srpms/glibc/bugs" }.should route_to(:controller => 'srpms',
    #                                                            :action => 'bugs',
    #                                                            :id => 'glibc')
    # end

    it "should route /en/Sisyphus/srpms/glibc/bugs to srpms#bugs" do
      { :get => "/en/Sisyphus/srpms/glibc/bugs" }.should route_to(:controller => 'srpms',
                                                                  :action => 'bugs',
                                                                  :id => 'glibc',
                                                                  :locale => 'en')
    end

    # TODO?
    # it "should route /Sisyphus/srpms/glibc/allbugs to srpms#allbugs" do
    #   { :get => "/Sisyphus/srpms/glibc/allbugs" }.should route_to(:controller => 'srpms',
    #                                                               :action => 'allbugs',
    #                                                               :id => 'glibc')
    # end

    it "should route /en/Sisyphus/srpms/glibc/allbugs to srpms#allbugs" do
      { :get => "/en/Sisyphus/srpms/glibc/allbugs" }.should route_to(:controller => 'srpms',
                                                                     :action => 'allbugs',
                                                                     :id => 'glibc',
                                                                     :locale => 'en')
    end

    # TODO?
    # it "should route /Sisyphus/srpms/glibc/repocop to srpms#repocop" do
    #   { :get => "/Sisyphus/srpms/glibc/repocop" }.should route_to(:controller => 'srpms',
    #                                                               :action => 'repocop',
    #                                                               :id => 'glibc')
    # end

    it "should route /en/Sisyphus/srpms/glibc/repocop to srpms#repocop" do
      { :get => "/en/Sisyphus/srpms/glibc/repocop" }.should route_to(:controller => 'srpms',
                                                                     :action => 'repocop',
                                                                     :id => 'glibc',
                                                                     :locale => 'en')
    end
  end
end