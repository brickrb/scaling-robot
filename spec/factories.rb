FactoryGirl.define do
  factory :package do
    name { Faker::Name.first_name.downcase }
  end
end
