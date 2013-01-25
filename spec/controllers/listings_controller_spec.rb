require 'spec_helper'

describe ListingsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'admin_index'" do
    it "returns http success" do
      get 'admin_index'
      response.should be_success
    end
  end

  describe "GET 'admin_edit'" do
    it "returns http success" do
      get 'admin_edit'
      response.should be_success
    end
  end

  describe "GET 'admin_new'" do
    it "returns http success" do
      get 'admin_new'
      response.should be_success
    end
  end

end
