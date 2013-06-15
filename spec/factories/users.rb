# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email = "foobar@example.com"
    password = "12345678"
    first_name = "Foo"
    last_name = "Bar"
    username = "FooBar"
    role = "user"
  end
end
