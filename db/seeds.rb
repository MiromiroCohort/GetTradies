require 'faker'
# add customers
10.times do
  User.create(username: Faker::Internet.user_name,
              given_name: Faker::Name.first_name,
              family_name: Faker::Name.last_name,
              email: Faker::Internet.safe_email,
              address: Faker::Address.street_address,
              description: Faker::Lorem.sentence,
              password_hash: Faker::Lorem.word)
end
# add tradies
10.times do
  User.create(username: Faker::Internet.user_name,
              given_name: Faker::Name.first_name,
              family_name: Faker::Name.last_name,
              email: Faker::Internet.safe_email,
              profession: ['builder','plumber','electrician', 'handy man', 'plasterer', 'painter', 'gardener'],
              address: Faker::Address.street_address,
              description: Faker::Lorem.sentence,
              rates: Faker::Commerce.price.to_f,
              password_hash: Faker::Lorem.word)
end

# add jobs
10.times do
  Job.create(customer_id: rand(1..10),
             tradie_id: [nil, rand(1..10)].sample,
             rating:[nil, rand(1..5)].sample,
             price: Faker::Commerce.price.to_f,
             location: ['Newtown', 'Te Aro', 'Karori', 'Johnsonville', 'Petone', 'Seatoun', 'Island Bay', 'Khandala', 'Kelburn'].sample,
             job_type: ['Building', 'Plumbing', 'Electical', 'Gardening', 'Painting', 'General Handy Work', 'Plastering'].sample,
             title: Faker::Lorem.sentence(rand(1..4)),
             description: Faker::Lorem.sentence,
             photo_url: Faker::Avatar.image,
             paid_at: [nil, Faker::Time.between(2.days.ago, Time.now)].sample)
end
