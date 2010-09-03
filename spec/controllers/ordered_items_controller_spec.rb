require 'spec_helper'

describe OrderedItemsController do

  def mock_ordered_item(stubs={})
    @mock_ordered_item ||= mock_model(OrderedItem, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all ordered_items as @ordered_items" do
      OrderedItem.stub(:all) { [mock_ordered_item] }
      get :index
      assigns(:ordered_items).should eq([mock_ordered_item])
    end
  end

  describe "GET show" do
    it "assigns the requested ordered_item as @ordered_item" do
      OrderedItem.stub(:find).with("37") { mock_ordered_item }
      get :show, :id => "37"
      assigns(:ordered_item).should be(mock_ordered_item)
    end
  end

  describe "GET new" do
    it "assigns a new ordered_item as @ordered_item" do
      OrderedItem.stub(:new) { mock_ordered_item }
      get :new
      assigns(:ordered_item).should be(mock_ordered_item)
    end
  end

  describe "GET edit" do
    it "assigns the requested ordered_item as @ordered_item" do
      OrderedItem.stub(:find).with("37") { mock_ordered_item }
      get :edit, :id => "37"
      assigns(:ordered_item).should be(mock_ordered_item)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created ordered_item as @ordered_item" do
        OrderedItem.stub(:new).with({'these' => 'params'}) { mock_ordered_item(:save => true) }
        post :create, :ordered_item => {'these' => 'params'}
        assigns(:ordered_item).should be(mock_ordered_item)
      end

      it "redirects to the created ordered_item" do
        OrderedItem.stub(:new) { mock_ordered_item(:save => true) }
        post :create, :ordered_item => {}
        response.should redirect_to(ordered_item_url(mock_ordered_item))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ordered_item as @ordered_item" do
        OrderedItem.stub(:new).with({'these' => 'params'}) { mock_ordered_item(:save => false) }
        post :create, :ordered_item => {'these' => 'params'}
        assigns(:ordered_item).should be(mock_ordered_item)
      end

      it "re-renders the 'new' template" do
        OrderedItem.stub(:new) { mock_ordered_item(:save => false) }
        post :create, :ordered_item => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested ordered_item" do
        OrderedItem.should_receive(:find).with("37") { mock_ordered_item }
        mock_ordered_item.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :ordered_item => {'these' => 'params'}
      end

      it "assigns the requested ordered_item as @ordered_item" do
        OrderedItem.stub(:find) { mock_ordered_item(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:ordered_item).should be(mock_ordered_item)
      end

      it "redirects to the ordered_item" do
        OrderedItem.stub(:find) { mock_ordered_item(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(ordered_item_url(mock_ordered_item))
      end
    end

    describe "with invalid params" do
      it "assigns the ordered_item as @ordered_item" do
        OrderedItem.stub(:find) { mock_ordered_item(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:ordered_item).should be(mock_ordered_item)
      end

      it "re-renders the 'edit' template" do
        OrderedItem.stub(:find) { mock_ordered_item(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested ordered_item" do
      OrderedItem.should_receive(:find).with("37") { mock_ordered_item }
      mock_ordered_item.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the ordered_items list" do
      OrderedItem.stub(:find) { mock_ordered_item }
      delete :destroy, :id => "1"
      response.should redirect_to(ordered_items_url)
    end
  end

end
