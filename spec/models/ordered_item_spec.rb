require 'spec_helper'

describe OrderedItem do
  it "should have the same cost as the item when the OrderedItem was created" do
    item = create :item, :cost => 2
    ordered = create :ordered_item, :item => item
    ordered.cost.should == 2
  end

  it "should maintain the cost separately from the item" do
    item = create :item, :cost => 2
    ordered = create :ordered_item, :item => item
    orig_cost = ordered.cost

    item.cost = 3
    item.save!
    ordered.reload
    ordered.cost.should == 2
  end
end
