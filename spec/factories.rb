FactoryGirl.define do

  factory :ownership do
    package_id "1"
    user_id "1"
  end

  factory :package do
    name { Faker::Name.first_name.downcase }
  end

  factory :user do
    email { Faker::Internet.email }
    password "foobarfoobar"
    password_confirmation "foobarfoobar"
    username { Faker::Internet.user_name }
  end

  factory :version do
    description { Faker::Lorem.paragraph }
    license "MIT"
    number { Faker::Number.digit }
    package_id "1"
    shasum "shasum"
  end
end
