# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    stripe_token "MyString"
    address "MyString"
    city "MyString"
    state "MyString"
    zipcode "MyString"
    coupon "MyString"
  end
end
