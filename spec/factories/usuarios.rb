FactoryGirl.define do
  factory :usuario do
    usuario { Faker::Pokemon.name }
    nombre { Faker::Name.first_name }
  end
end