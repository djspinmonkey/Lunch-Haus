class Order < ActiveRecord::Base
  belongs_to :orderer, :class_name => "User"
  belongs_to :fulfiller, :class_name => "User"
  has_many :ordered_items, :dependent => :destroy
  has_many :items, :through => :ordered_items
  accepts_nested_attributes_for :items

  scope :fulfilled, where('fulfiller_id is not null')

  validates_presence_of :orderer
  validate :must_have_items
  validate :must_have_valid_date

  before_save :initialize_cost

  def must_have_items
    errors.add :base, "Must include at least one item" if self.items.empty?
  end

  def must_have_valid_date
    errors.add :date, 'must be a valid date' unless self.date.kind_of? Time
  end

  def initialize_cost
    self.cost = self.expected_cost if self.fulfilled? and self.cost.nil?
  end

  def add_item (item)
    self.ordered_items << OrderedItem.create(:item => item, :order => self)
    self.items
  end

  def expected_cost
    self.ordered_items.collect(&:cost).sum
  end

  def fulfilled?
    !self.fulfiller_id.nil?
  end
end
