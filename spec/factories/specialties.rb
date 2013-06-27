# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :specialty do
    sequence(:title) {|n| "Body Building #{n}" }
  end
end
