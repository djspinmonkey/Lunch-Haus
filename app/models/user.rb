class User < ActiveRecord::Base
  has_many :accepted_orders, :class_name => 'Order', :foreign_key => 'accepter_id'
  has_many :placed_orders, :class_name => 'Order', :foreign_key => 'orderer_id'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  # Returns all users with a positive balance.
  #
  def self.with_positive_balance
    self.all.select { |u| u.balance > 0 }
  end

  # Returns all users with a negative balance.
  #
  def self.with_negative_balance
    self.all.select { |u| u.balance < 0 }
  end

  # Shows the net total owed to this user.  A negative balance indicates that
  # this user owes money.
  #
  def balance
    # TODO This may eventually get unwieldy.  We can combine these queries or
    # cache the balance if/when scaling becomes an issue.
    payments_made     = Payment.where(:payer_id     => self.id).sum(:amount)
    payments_received = Payment.where(:recipient_id => self.id).sum(:amount)
    orders_placed     = Order.accepted.where(:orderer_id  => self.id).sum(:cost)
    orders_accepted   = Order.accepted.where(:accepter_id => self.id).sum(:cost)

    (payments_made + orders_accepted - payments_received - orders_placed).to_f
  end
end
