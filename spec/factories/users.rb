FactoryBot.define do
  factory :user do
    name {"ExampleUser"}
    introduction {"hello!"}
    email {"user@gmail.com"}
    password {"password"}
    password_confirmation {"password"}
  end
end