require 'spec_helper'

describe "payments/show.html.haml" do
  before(:each) do
    @payment = assign(:payment, stub_model(Payment,
      :payer_id => 1,
      :recipient_id => 1,
      :amount => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(1.5.to_s)
  end
end
