# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member, class: User do
    sequence(:email) {|n| "trainer#{n}@example.com" }
    password "12345678"
    first_name "Mem"
    last_name "Ber"
    username "Member"
    role "member"
  end

  factory :trainer, class: User do
    sequence(:email) {|n| "member#{n}@example.com" }
    password "12345678"
    first_name "Train"
    last_name "Er"
    username "Trainer"
    role "trainer"
  end
end
