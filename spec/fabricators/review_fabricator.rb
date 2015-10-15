Fabricator(:review) do
  stars   { [1, 2, 3, 4, 5].sample }
  content { Faker::Lorem.paragraph }
  user
end
