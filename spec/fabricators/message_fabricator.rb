Fabricator(:message) do
  title   { Faker::Lorem.word }
  content { Faker::Lorem.paragraph }
end
