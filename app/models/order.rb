class Order < ActiveRecord::Base
  belongs_to :orderer, :class_name => "User"
  belongs_to :fulfiller, :class_name => "User"
  has_many :ordered_items
  has_many :items, :through => :ordered_items

  scope :fulfilled, where('fulfiller_id is not null')

  validates_presence_of :orderer

  before_save :initialize_cost

  def initialize_cost
    self.cost = self.expected_cost if self.fulfilled? and self.cost.nil?
  end

  def add_item (item)
    self.ordered_items << OrderedItem.create(:item => item, :order => self)
  end

  def expected_cost
    self.ordered_items.collect(&:cost).sum
  end

  def fulfilled?
    !self.fulfiller_id.nil?
  end
end
