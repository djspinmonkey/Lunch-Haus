class Order < ActiveRecord::Base
  belongs_to :orderer, :class_name => "User"
  belongs_to :fulfiller, :class_name => "User"
  has_many :ordered_items
  has_many :items, :through => :ordered_items

  validates_presence_of :orderer

  def add_item (item)
    self.ordered_items << OrderedItem.create(:item => item, :order => self)
  end

  def cost
    self.ordered_items.collect(&:item).collect(&:cost).inject(0, &:+)
  end

end
