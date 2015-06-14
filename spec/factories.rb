FactoryGirl.define do

  factory :package do
    name { Faker::Name.first_name.downcase }
  end

  factory :user do
    email { Faker::Internet.email }
    password "foobarfoobar"
    password_confirmation "foobarfoobar"
    username { Faker::Internet.user_name }
  end
end
