require 'factory_girl/syntax/blueprint'
require 'factory_girl/syntax/make'
require 'factory_girl/syntax/sham'
require 'faker'

User.blueprint do
  name { Faker::Name.name }
end

Order.blueprint do
  orderer { User.make }
end

Restaurant.blueprint do
  name { Faker::Company.name }
end

Sham.cost { |n| n / 2.0 }

Item.blueprint do
  name { Faker::Lorem.words(1) }
  cost { Sham.cost }
end
