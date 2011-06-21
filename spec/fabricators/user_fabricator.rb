Fabricator(:user) do
  first_name    Faker::Name.first_name
  last_name     Faker::Name.last_name
  email         "testuser@somewhere.com"
  information   Faker::Lorem.sentences(4).join(" ")
end