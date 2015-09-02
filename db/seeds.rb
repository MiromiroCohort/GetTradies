
user_names = ["tj", "bobbo", "theman", "elle", "smelly", "jelly", "hellu", "Marco", "Ingle", "Lenin"]
first_names = ["Mike", "Joe", "Kelly", "Anna", "Bob", "Gabe", "Popeye", "Hercules", "Ippeee", "Addie"]
last_names = ["Squid", "Fish", "Dog", "Cowman", "Balls", "Ocean", "Sodom", "Seven", "Teeth", "Moneyshot"]
emails = ["asdfsadf@dsasdf", "ERTQWr@ASSADF", "asdfsa@rtdtyh", "2@3", "email@sbemail", "User@name.come", "Kingdom@ofheven.nz", "eight@mate.hate", "install@yuoballs.zn", "Lies@pies.mys"]
addresses = ["1 road", "2 street", "3 lane", "4 ave", "5 gil", "6 alley", "7 highway", "8 Route", "9 Boulavard", "10 Canal"]
descriptions = ["asdfasdfasd", "ewsdfasdfa", "3asdfasdf", "4sadfasdfasdfas", "5asdklhaeskfjh aaskjfh", "6 yes ser", "7 heavean", "8 goin to 'bate", "9 fine fine", "10, good men"]
user_names2 = user_names.shuffle
first_names2 = first_names.shuffle
last_names2 = last_names.shuffle
emails2 = ["john@join", "mon@moin", "hon@hoin", "bon@bnoib", "kon@koin", "ron@roin", "lomn@lin", "8@mate", "nine@mine", "ten@hen"]
descriptions2 = descriptions.shuffle

# add customers
10.times do |i|
 User.create(username: user_names[i],
             given_name: first_names[i],
             family_name: last_names[i],
             email: emails[i],
             address: addresses[i],
             description: descriptions[i],
             password_hash: user_names[i])
end
# add tradies
10.times do |i|
 User.create(username: user_names2[i],
             given_name: first_names2[i],
             family_name: last_names2[i],
             email: emails2[i],
             profession: ['builder','plumber','electrician', 'handy man', 'plasterer', 'painter', 'gardener'].sample,
             address: addresses[i],
             description: descriptions2[i],
             password_hash: user_names2[i])
  User.create(username: user_names[i],
              given_name: first_names[i],
              family_name: last_names[i],
              email: emails[i],
              address: addresses[i],
              description: descriptions[i],
              password_hash: user_names[i])
end
# add tradies
10.times do |i|
  User.create(username: user_names2[i],
              given_name: first_names2[i],
              family_name: last_names2[i],
              email: emails2[i],
              profession: ['builder','plumber','electrician', 'handy man', 'plasterer', 'painter', 'gardener'].sample,
              address: addresses[i],
              description: descriptions2[i],
              password_hash: user_names2[i])
end
prices = [33.33,11.11,44.44,55.55,99.99,56.78,54.32,87.90,12.22,41.56]
job_description = ["running", "gunning", "sunning", "bunning", "cunning", "hunning", "zunning", "lunning", "munning", "eunning"]
titles = ["flight", "fight", "fright", "might", "white", "kite", "gite", "slight", "dite", "wright"]

# add jobs
10.times do |i|
 Job.create(user_id: rand(1..10),
            price: prices[i],
            location: ['Newtown', 'Te Aro', 'Karori', 'Johnsonville', 'Petone', 'Seatoun', 'Island Bay', 'Khandala', 'Kelburn'].sample,
            job_type: ['Building', 'Plumbing', 'Electical', 'Gardening', 'Painting', 'General Handy Work', 'Plastering'].sample,
            title: titles[i],
            description: job_description[i])
  Job.create(user_id: rand(1..10),
             price: prices[i],
             location: ['Newtown', 'Te Aro', 'Karori', 'Johnsonville', 'Petone', 'Seatoun', 'Island Bay', 'Khandala', 'Kelburn'].sample,
             job_type: ['Building', 'Plumbing', 'Electical', 'Gardening', 'Painting', 'General Handy Work', 'Plastering'].sample,
             title: titles[i],
             description: job_description[i])
end


5.times do |i|
  Tender.create(job_id: rand(1..10),
                user_id: rand(11..20),
                comment: descriptions.sample)
end
