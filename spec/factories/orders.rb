FactoryGirl.define do
  factory :order do
    sequence(:name) {|n| "Random Person #{n + 1}"}
    address "MyText"
    sequence(:email) {|n| "randomperson#{n + 1}@example.com"}
    pay_type "Check"
  end
end
