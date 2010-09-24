require 'factory_girl/syntax/blueprint'
require 'factory_girl/syntax/make'
require 'factory_girl/syntax/sham'
require 'faker'

User.blueprint do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  password { Faker::Lorem.words(3).join('').first(6).to_s }  # Join 3 words to guarantee the 6 char minimum
end

Restaurant.blueprint do
  name { Faker::Company.name }
end

Order.blueprint do
  orderer { User.make }
  ordered_items { |order| [ OrderedItem.make(:order => order) ] }
  date { Time.now }
end

Sham.cost { |n| n / 2.0 }

Item.blueprint do
  name { Faker::Lorem.words(1).first }
  cost { Sham.cost }
end

OrderedItem.blueprint do
  order { Order.make }
  item { Item.make }
end

Payment.blueprint do
  payer { User.make }
  recipient { User.make }
  amount { Sham.cost }
end
