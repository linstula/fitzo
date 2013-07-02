# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    street_address "337 Summer Street"
    city "Boston"
    state "MA"
    zip_code "02210"
  end
end
