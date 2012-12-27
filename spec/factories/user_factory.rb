FactoryGirl.define do
  factory :user do
    email 
    password 'abc123'
    password_confirmation 'abc123'
  end
end

FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end

FactoryGirl.define do
  sequence :password do |n|
    "password#{n}"
  end
end
