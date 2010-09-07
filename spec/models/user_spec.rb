require 'spec_helper'

describe User do
  before :all do
    @alice = User.make
    @bob = User.make
    @charlie = User.make

    Order.make(:orderer => @bob,   :fulfiller => @alice,   :cost => 5)
    Order.make(:orderer => @alice, :fulfiller => @charlie, :cost => 3)
    Order.make(:orderer => @alice, :fulfiller => @charlie, :cost => 5)
    Order.make(:orderer => @alice, :fulfiller => nil,      :cost => nil)
  end

  context '#balance' do
    it "should show the net amount owed to/by the user" do
      @alice.balance.should == -3
      @bob.balance.should == -5
      @charlie.balance.should == 8
    end
  end

  context '.with_positive_balance' do
    it "should return all users with a positive balance" do
      users = User.with_positive_balance
      users.should have(1).users
      users.should include(@charlie)
    end
  end

  context '.with_negative_balance' do
    it 'should return all users with a negative balance' do
      users = User.with_negative_balance
      users.should have(2).users
      users.should include(@alice, @bob)
    end
  end
end
