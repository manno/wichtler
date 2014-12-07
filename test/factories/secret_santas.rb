FactoryGirl.define do
  factory :secret_santa do
    santa { create :person }
    receiver { create :person }
  end
end
