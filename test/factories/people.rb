FactoryGirl.define do
  factory :person do
    name "MyString"
    email  { generate :email }
    state "new"
    active false
  end

end
