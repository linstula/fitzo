# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
    title "MyString"
    description "MyText"
    duration 1
    price 1
    sequence(:category) {|n| "Category#{n}" }
    association :user, factory: :trainer
  end
end
