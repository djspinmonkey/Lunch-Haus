require 'spec_helper'

describe OrderedItem do
  it "should have the same cost the item has when the OrderedItem was created" do
    item = Item.make :cost => 2
    ordered = OrderedItem.make :item => item
    ordered.cost.should == 2
  end

  it "should maintain the cost separately from the item" do
    item = Item.make :cost => 2
    ordered = OrderedItem.make :item => item
    orig_cost = ordered.cost

    item.cost = 3
    item.save!
    ordered.reload
    ordered.cost.should == 2
  end
end
