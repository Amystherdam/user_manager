FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    password { '12345678' }
    full_name { 'User' }
    role { 1 }
  end
end
