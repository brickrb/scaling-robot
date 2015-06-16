FactoryGirl.define do

  factory :oauth_access_token, class: "Doorkeeper::AccessToken" do
    transient do
      user nil
    end
    application_id 1
    token 'abc123'
    trait :with_application do
      association :application, factory: :oauth_application
    end
  end

  factory :oauth_application, class: "Doorkeeper::Application" do
    sequence(:name) { |n| "Application #{n}" }
    sequence(:uid) { |n| n }
    redirect_uri "http://www.example.com/callback"
  end

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
