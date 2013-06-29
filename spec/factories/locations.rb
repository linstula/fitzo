# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    street_address "MyString"
    city "MyString"
    state "MyString"
    zip_code 1
    loc_name "MyString"
    neighborhood "MyString"
    latitude 1.5
    longitude 1.5
  end
end
