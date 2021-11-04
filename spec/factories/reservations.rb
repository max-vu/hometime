FactoryBot.define do
  factory :reservation do
    code { Faker::Code.nric }
    start_date { Time.current + 1.day }
    end_date { Time.current + 3.days }
    nights { 4 }
    guests { 2 }
    adults { 2 }
    children { 0 }
    currency { 'AUD' }
    payout_price { 375.0 }
    security_price { 175.0 }
    total_price { 650.0 }
  end
end
