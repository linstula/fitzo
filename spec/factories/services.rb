# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
    title "MyString"
    description "MyText"
    duration 1
    price 1
    category "MyString"
    user_id ""
  end
end
