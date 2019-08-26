require_relative('../models/user')
require_relative('../models/destination')
require_relative('../models/travel')
require_relative('../models/experience')

user1 = User.new({
  "name" => "Rose",
  "home_location" => "Glasgow"
})

user1.save

destination1 = Destination.new({
  "name" => "Kelvinhall Museum",
  "priority" => 3,
  "reason_to_go" => "Beautiful building and place to visit.",
  "travel_method" => "Bus and short walk.",
  "visited_or_not" => true
})

destination1.save

experience1 = Experience.new({
  "name" => "Visit to Kelvinhall",
  "description" => "Beautiful sunny day, lovely time.",
  "destination_id" => destination1.id
  })

experience1.save

travel1 = Travel.new({
  "user_id" => user1.id,
  "destination_id" => destination1.id,
  "travel_date" => '2013-06-14'
  })

travel1.save
