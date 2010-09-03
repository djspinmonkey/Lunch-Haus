require "spec_helper"

describe OrdersController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/orders" }.should route_to(:controller => "orders", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/orders/new" }.should route_to(:controller => "orders", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/orders/1" }.should route_to(:controller => "orders", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/orders/1/edit" }.should route_to(:controller => "orders", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/orders" }.should route_to(:controller => "orders", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/orders/1" }.should route_to(:controller => "orders", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/orders/1" }.should route_to(:controller => "orders", :action => "destroy", :id => "1")
    end

  end
end
