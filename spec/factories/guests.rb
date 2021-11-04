FactoryBot.define do
  factory :guest do
    sequence(:email) { |i| "user.#{i}@example.com" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
