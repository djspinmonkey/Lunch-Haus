require "spec_helper"

describe OrderedItemsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/ordered_items" }.should route_to(:controller => "ordered_items", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/ordered_items/new" }.should route_to(:controller => "ordered_items", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/ordered_items/1" }.should route_to(:controller => "ordered_items", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/ordered_items/1/edit" }.should route_to(:controller => "ordered_items", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/ordered_items" }.should route_to(:controller => "ordered_items", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/ordered_items/1" }.should route_to(:controller => "ordered_items", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/ordered_items/1" }.should route_to(:controller => "ordered_items", :action => "destroy", :id => "1")
    end

  end
end
