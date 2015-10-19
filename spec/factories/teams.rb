require 'faker'
FactoryGirl.define do
  factory :team do
    name Faker::Name.name
  end
end

FactoryGirl.define do
  factory :opponent_team do
    name Faker::Name.name
  end
end
