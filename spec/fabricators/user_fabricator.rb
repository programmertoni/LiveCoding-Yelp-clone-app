Fabricator(:user) do
  full_name { Faker::Name.name }
  password  { Faker::Internet.password }
  role      { %w(user owner).sample }
end
