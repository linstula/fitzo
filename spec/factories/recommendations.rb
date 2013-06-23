# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recommendation do
    title "This is a recommendation title"
    content "This is the content for a recommendation."
    association :user, factory: :member
    association :trainer_profile, factory: :trainer_profile
  end
end
