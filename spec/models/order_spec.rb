require 'spec_helper'

describe Order do
  context '.accepted' do
    it 'should return all accepted orders' do
      alice = create :user
      bob = create :user

      order1 = create :order, :orderer => alice, :accepter => bob
      order2 = create :order, :orderer => bob,   :accepter => nil
      order3 = create :order, :orderer => bob,   :accepter => alice

      Order.accepted.should have(2).accepted_orders
      Order.accepted.should include(order1, order3)
    end
  end

  context '#accepted?' do
    it "should return false if the order is not accepted" do
      create(:order, :accepter => nil).should_not be_accepted
    end

    it "should return true if the order is accepted" do
      create(:order, :accepter => create(:user)).should be_accepted
    end
  end

  context '#expected_cost' do
    it "should return the sum of the cost of its ordered items" do
      order = create :order
      order.items.clear
      order.items << create(:item, :cost => 1.5)
      order.items << create(:item, :cost => 2)
      order.expected_cost.should == 3.5
    end
  end

  context '#cost' do
    before do
      @order = create :order
      @order.items.clear
      @item = create :item, :cost => 2
      @order.items << @item
      @order.save
    end

    context "before the order is accepted" do
      it "should be nil" do
        @order.cost.should be_nil
      end
    end

    context "after the order is accepted" do
      before do
        @order.accepter = create :user
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
