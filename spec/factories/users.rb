FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "testuser#{n + 1}"}
    password "password"
  end
end
