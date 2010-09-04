class User < ActiveRecord::Base
  has_many :fulfilled_orders, :class_name => 'Order', :foreign_key => 'fulfiller_id'
  has_many :placed_orders, :class_name => 'Order', :foreign_key => 'orderer_id'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  scope :with_positive_balance, joins(:fulfilled_orders).joins(:placed_orders).where('sum(fulfilled_orders.cost) > sum(placed_orders.cost)')

  # Shows the net total owed to this user.  A negative balance indicates that
  # this user owes money.
  #
  def balance
    # TODO This will eventually get unwieldy, but I'm implementing the simplest
    # thing that will work for now.  Refactor when scaling becomes an issue.
    Order.find_all_by_fulfiller_id(self.id).collect(&:cost).sum - Order.fulfilled.where(:orderer => self).collect(&:cost).sum
  end
end
