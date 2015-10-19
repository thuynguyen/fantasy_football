require 'faker'
FactoryGirl.define do
  factory :user do
    first_name Faker::Name.name
    last_name Faker::Name.name
  end
end



