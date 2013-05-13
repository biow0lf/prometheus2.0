require 'spec_helper'

describe Api::SrpmsController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'changelog'" do
    it "returns http success" do
      get 'changelog'
      response.should be_success
    end
  end

end
