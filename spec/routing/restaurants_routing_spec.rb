require "spec_helper"

describe RestaurantsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/restaurants" }.should route_to(:controller => "restaurants", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/restaurants/new" }.should route_to(:controller => "restaurants", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/restaurants/1" }.should route_to(:controller => "restaurants", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/restaurants/1/edit" }.should route_to(:controller => "restaurants", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/restaurants" }.should route_to(:controller => "restaurants", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/restaurants/1" }.should route_to(:controller => "restaurants", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/restaurants/1" }.should route_to(:controller => "restaurants", :action => "destroy", :id => "1")
    end

  end
end
