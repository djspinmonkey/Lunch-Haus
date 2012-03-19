require 'spec_helper'

describe OrderAcceptancesController do
  describe "POST create" do
    let(:order) { create :order }
    let(:user)  { create :user }

    before do
      sign_in :user, user
      Order.stub(:find) { order }
      User.stub(:find) { user }
      post(:create, :order_acceptances => [{:order => {:id => order.id}, :user => {:id => user.id}}])
    end

    subject { response }

    its(:status) { should == 200 }

    it "should assign a fulfiller to an order" do
      order.reload
      order.accepter.should == user
    end

    context "with an unknown user" do
      before do
        User.stub(:find) { raise ActiveRecord::RecordNotFound, "user not found" }
        post(:create, :order_acceptances => [{:order => {:id => order.id}, :user => {:id => user.id}}])
      end
      subject { response }

      its(:status) { should == 404 }
      its(:body) { should include "user not found" }
    end

    context "with an unknown order" do
      before do
        Order.stub(:find) { raise ActiveRecord::RecordNotFound, "order not found" }
        post(:create, :order_acceptances => [{:order => {:id => order.id}, :user => {:id => user.id}}])
      end
      subject { response }

      its(:status) { should == 404 }
      its(:body) { should include "order not found" }
    end

    context "when there is an internal error" do
      before do
        User.stub(:find) { raise "OH NOES" }
        post(:create, :order_acceptances => [{:order => {:id => order.id}, :user => {:id => user.id}}])
      end
      subject { response }

      its(:status) { should == 500 }
      its(:body) { should include "OH NOES" }
    end
  end
end
