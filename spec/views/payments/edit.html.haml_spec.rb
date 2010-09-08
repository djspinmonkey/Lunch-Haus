require 'spec_helper'

describe "payments/edit.html.haml" do
  before(:each) do
    @payment = assign(:payment, stub_model(Payment,
      :new_record? => false,
      :payer_id => 1,
      :recipient_id => 1,
      :amount => 1.5
    ))
  end

  it "renders the edit payment form" do
    render

    rendered.should have_selector("form", :action => payment_path(@payment), :method => "post") do |form|
      form.should have_selector("input#payment_payer_id", :name => "payment[payer_id]")
      form.should have_selector("input#payment_recipient_id", :name => "payment[recipient_id]")
      form.should have_selector("input#payment_amount", :name => "payment[amount]")
    end
  end
end
