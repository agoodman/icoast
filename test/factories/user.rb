FactoryGirl.define do
  factory :user do
    email { generate(:email) }
    password "password"
  end
  sequence(:email) {|n| "user#{n}@test.com"}
end
