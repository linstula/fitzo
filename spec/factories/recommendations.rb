# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recommendation do
    title "MyString"
    content "MyText"
    user_id 1
    trainer_profile_id 1
  end
end
