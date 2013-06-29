# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    street_address "123 ABC Street"
    city "Boston"
    state "MA"
  end
end
