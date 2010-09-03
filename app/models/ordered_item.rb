class OrderedItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  validates_presence_of :order
  validates_presence_of :item

  before_create :set_cost

  def set_cost
    self.cost = self.item.cost
  end
end
