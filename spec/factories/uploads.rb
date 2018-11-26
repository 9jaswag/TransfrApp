FactoryBot.define do
  factory :upload do
    name { Faker::Name.unique.first_name[1..10] }
  end
end
