require 'spec_helper'

describe User do
  before :all do
    @alice    = create(:user)
    @bob      = create(:user)
    @charlie  = create(:user)

    create(:order, :orderer => @bob,   :accepter => @alice,   :cost => 5)
    create(:order, :orderer => @alice, :accepter => @charlie, :cost => 3)
    create(:order, :orderer => @alice, :accepter => @charlie, :cost => 5)
    create(:order, :orderer => @alice, :accepter => nil,      :cost => nil)

    create(:payment, :payer => @bob, :recipient => @charlie, :amount => 3)
  end

  describe '.with_positive_balance' do
    it "should return all users with a positive balance" do
      users = User.with_positive_balance
      users.should have(1).users
      users.should include(@charlie)
    end
  end

  describe '.with_negative_balance' do
    it 'should return all users with a negative balance' do
      users = User.with_negative_balance
      users.should have(2).users
      users.should include(@alice, @bob)
    end
  end

  describe '#balance' do
    it "should show the net amount owed to/by the user" do
      @alice.balance.should == -3
      @bob.balance.should == -2
      @charlie.balance.should == 5
    end
  end

end
