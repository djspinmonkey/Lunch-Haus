class Payment < ActiveRecord::Base
  belongs_to :payer, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'
end
