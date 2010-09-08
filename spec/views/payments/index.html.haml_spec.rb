require 'spec_helper'

describe "payments/index.html.haml" do
  before(:each) do
    assign(:payments, [
      stub_model(Payment,
        :payer_id => 1,
        :recipient_id => 1,
        :amount => 1.5
      ),
      stub_model(Payment,
        :payer_id => 1,
        :recipient_id => 1,
        :amount => 1.5
      )
    ])
  end

  it "renders a list of payments" do
    render
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.5.to_s, :count => 2)
  end
end
