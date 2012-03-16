class OrderAcceptancesController < ApplicationController
  #before_filter :authenticate_user!  # TODO: fix specs to not asplode with this

  def create
    Order.transaction do
      params[:order_acceptances].each do |acc|
        order = Order.find acc[:order][:id]
        user  = User.find  acc[:user ][:id]
        order.accepter = user
        order.save!
      end
      head :ok
    end
  rescue ActiveRecord::RecordNotFound => e
    render :json => [:errors => [e.message]], :status => 404
  rescue StandardError => e
    render :json => [:errors => [e.message]], :status => 500
  end

  def destroy
    order = Order.find params[:order_acceptance][:id]
    order.accepter = nil
    order.save!
  rescue StandardError => e
    render :json => [:errors => [e.message]], :status => 500
  end
end
