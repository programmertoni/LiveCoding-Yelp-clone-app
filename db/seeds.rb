# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do
  User.create(full_name: Faker::Name.name,
              password: 'password',
              role: %w(user owner).sample)
end

City.create(name: 'Dublin', country: 'Ireland')
City.create(name: 'London', country: 'United Kindom')
City.create(name: 'New York', country: 'United States')

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


user  = User.create(full_name: 'Toni Cesarek',
                   password: 'password',
                   role: 'user')

owner = User.create(full_name: 'Owner Toni',
                    password: 'password',
                    role: 'owner')

admin = User.create(full_name: 'Admin Toni',
                    password: 'password',
                    role: 'user')

admin.update(role: 'admin')

10.times do
  Company.create(name: Faker::Company.name,
                 price_range: (1..5).to_a.sample,
                 owner: [owner, admin].sample,
                 city_id: City.all.pluck(:id).sample)
end

Company.all.each do |company|
  (1..3).to_a.sample.times do
    company.categories << Category.all.sample
  end
end

200.times do
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
