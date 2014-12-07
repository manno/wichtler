FactoryGirl.define do

  sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :admin_user do
    email  { generate :email }
    password "admin123"
  end

end
