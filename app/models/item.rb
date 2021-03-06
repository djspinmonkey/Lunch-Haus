class Item < ActiveRecord::Base
  belongs_to :restaurant

  validates_presence_of :name
  validates_presence_of :cost
  validates_numericality_of :cost

  def <=> ( other )
    self.name <=> other.name
  end
end
