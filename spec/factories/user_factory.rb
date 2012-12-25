FactoryGirl.define do
  factory :user do
    email 'john@test.com'
    password 'abc123'
    password_confirmation 'abc123'
  end
end
