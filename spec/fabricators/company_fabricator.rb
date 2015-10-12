Fabricator(:company) do
  name         { Faker::Company.name }
  city_id      { (1..10).to_a.sample }
  price_range  { (1..5).to_a.sample }
  category_ids { Fabricate(:category).id }
end
