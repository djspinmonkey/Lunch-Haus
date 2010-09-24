require 'spec_helper'

describe Order do
  context '.accepted' do
    it 'should return all accepted orders' do
      alice = User.make
      bob = User.make

      order1 = Order.make(:orderer => alice, :accepter => bob)
      order2 = Order.make(:orderer => bob,   :accepter => nil)
      order3 = Order.make(:orderer => bob,   :accepter => alice)

      Order.accepted.should have(2).accepted_orders
      Order.accepted.should include(order1, order3)
    end
  end

  context '#add_item' do
    it "should add an item to the order" do
      order = Order.spawn
      item1 = Item.make
      item2 = Item.make
      order.add_item item1
      order.add_item item2
      order.items.should have(2).items
      order.items.should include(item1, item2)
    end
  end

  context '#accepted?' do
    it "should return false if the order is not accepted" do
      Order.make(:accepter => nil).should_not be_accepted
    end

    it "should return true if the order is accepted" do
      Order.make(:accepter => User.make).should be_accepted
    end
  end

  context '#expected_cost' do
    it "should return the sum of the cost of its ordered items" do
      order = Order.make
      order.add_item Item.make(:cost => 1.5)
      order.add_item Item.make(:cost => 2)
      order.expected_cost.should == 3.5
    end
  end

  context '#cost' do
    before do
      @order = Order.make
      @item = Item.make(:cost => 2)
      @order.add_item @item
      @order.save
    end

    context "before the order is accepted" do
      it "should be nil" do
        @order.cost.should be_nil
      end
    end

    context "after the order is accepted" do
      before do
        @order.accepter = User.make
        @order.save
      end

      it "should be set" do
        @order.cost.should == @item.cost
      end

      it "should be able to be updated" do
        new_cost = @item.cost + 5

        @order.cost = new_cost
        @order.save
        @order.reload
        @order.cost.should == new_cost
      end
    end
  end
end
