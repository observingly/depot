FactoryGirl.define do
  factory :product do
    sequence(:title) {|n| "Product #{n + 1} "}
    description 'This is a good shirt'
    image_url 'http://test.com/wat.jpg'
    price 5.00
  end
end
