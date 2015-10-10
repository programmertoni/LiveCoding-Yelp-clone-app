# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times do
  User.create(full_name: Faker::Name.name,
              password: 'password',
              role: %w(user owner).sample)
end

ljubljana = City.create(name: 'Ljubljana', country: 'Slovenia')
london    = City.create(name: 'London', country: 'United Kindom')
berlin    = City.create(name: 'Berlin', country: 'Germany')

Category.create(title: 'Spa')
Category.create(title: 'Hotel')
Category.create(title: 'Restaurant')
Category.create(title: 'Food')
Category.create(title: 'Nightlife')
Category.create(title: 'Shopping')
Category.create(title: 'Bar')
Category.create(title: 'Health')
Category.create(title: 'Education')
Category.create(title: 'Fnancal Services')
Category.create(title: 'Travel')


user  = User.create(full_name: Faker::Name.name,
                   password: 'password',
                   role: %w(user owner).sample)

owner = User.create(full_name: Faker::Name.name,
                    password: 'password',
                    role: %w(user owner).sample)

admin = User.create(full_name: Faker::Name.name,
                    password: 'password',
                    role: %w(user owner).sample)

admin.update(role: 'admin')

100.times do
  Company.create(name: Faker::Company.name,
                 price_range: (1..5).to_a.sample,
                 owner: [owner, admin].sample,
                 city_id: City.all.pluck(:id).sample)
end

100.times do
  Review.create(stars: (1..5).to_a.sample,
                content: Faker::Lorem.word,
                user_id: (1..20).to_a.sample,
                company: ([owner, admin].sample).companies.sample)
end

puts "*"*100
puts "Helo Master".center(100)
puts "*"*100
puts
puts "Created some fake data for you"
puts '_'*100
puts
puts "#{User.all.count} users"
puts "#{City.all.count} cities"
puts "#{Company.all.count} companies"
puts "#{Category.all.count} categories"
puts "#{Review.all.count} reviews"
