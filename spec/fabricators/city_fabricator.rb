Fabricator(:city) do
  name    { Faker::Lorem.word }
  country { Faker::Lorem.words(2).join(' ') }
end
