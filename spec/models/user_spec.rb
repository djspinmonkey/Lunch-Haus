require 'spec_helper'

describe User do
  before :all do
    @alice = User.make
    @bob = User.make
    @charlie = User.make

    @basic   = Item.make :name => "Basic Burrito",   :cost => 5
    @awesome = Item.make :name => "Awesome Burrito", :cost => 7

    Order.make(:orderer => @bob,   :fulfiller => @alice  ).add_item @awesome
    Order.make(:orderer => @alice, :fulfiller => @charlie).add_item @basic
    Order.make(:orderer => @alice, :fulfiller => @charlie).add_item @basic
    Order.make(:orderer => @alice, :fulfiller => nil).add_item @basic
  end

  context '#balance' do
    it "should show the net amount owed to/by the user" do
      @alice.balance.should == @awesome.cost - @basic.cost - @basic.cost
      @bob.balance.should == 0 - @awesome.cost
      @charlie.balance.should == @basic.cost + @basic.cost
    end
  end

  context '.with_positive_balance' do
    it "should return all users with a positive balance" do
      pending "track cost of orders"
      users = User.with_positive_balance
      users.should have(1).users
      users.should include(@charlie)
    end
  end

  context '.with_negative_balance' do
    it 'should return all users with a negative balance' do
      pending "track cost of orders"
      users = User.with_negative_balance
      users.should have(2).users
      users.should include(@alice, @bob)
    end
  end
end
