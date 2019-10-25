Fabricator(:user) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { Faker::Internet.email }
  birthday { 18.years.ago }
  password { Faker::Internet.password(min_length: 8) }
  city { Faker::Address.city }
  country { Faker::Address.country_code }
  roles { [:visitor] }
end

Fabricator :admin, from: :user do
  roles { [:visitor, :admin] }
end