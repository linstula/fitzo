# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :specialty do
    title "Specialty Title"
    association :trainer_profile, factory: :trainer_profile
  end
end
