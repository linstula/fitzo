# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
    title "Service Title"
    description "This is a description of my service"
    duration 60
    price 50
    sequence(:category) {|n| "Category#{n}" }
    association :trainer_profile, factory: :trainer_profile
  end
end
