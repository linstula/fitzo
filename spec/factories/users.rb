# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "foobar@example.com"
    password "12345678"
    first_name "Foo"
    last_name "Bar"
    username "FooBar"
    role "user"
  end

  factory :trainer, class: User do
    email "trainer@example.com"
    password "12345678"
    first_name "Foo"
    last_name "Bar"
    username "Trainer"
    role "trainer"
  end
end
