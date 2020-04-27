FactoryBot.define do
  factory :comment do
    comment {"とてもいい店でオススメです"}
    user
    shop
  end
end