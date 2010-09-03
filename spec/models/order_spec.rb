require 'spec_helper'

describe Order do
  it "should be able to have items added to it" do
    order = Order.make
    item1 = Item.make
    item2 = Item.make
    order.add_item item1
    order.add_item item2
    order.items.should have(2).items
    order.items.should include(item1, item2)
  end

  it "should have a cost equal to the sum of its ordered items" do
    order = Order.make
    item1 = Item.make(:cost => 1.5)
    item2 = Item.make(:cost => 2)
    order.add_item item1
    order.add_item item2
    order.cost.should == 3.5
  end
end
