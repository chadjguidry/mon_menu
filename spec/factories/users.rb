FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "!Simplepass"
    password_confirmation "!Simplepass"
  end
end
