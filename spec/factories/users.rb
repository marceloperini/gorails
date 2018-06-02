require 'cpf_faker'

FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "foo#{i}@bar.com" }
    nickname 'MyNickName'
    first_name 'MyFirstName'
    last_name 'MyLastName'
    password '12345678'
    password_confirmation '12345678'
    cpf '503.887.476-25'
    bio 'Foobar Foobar'
    company 'Foobar'
    gender 'F'
    job_title 'Foo Bar'
    phone '22222222'
    celphone '2222222'
    schooling 'Foo'
    birth_date Date.today
    marital_status 'S'
    father 'Foother'
    mother 'Bather'
    consignor_organ 'SSP'
    place_of_birth 'Foo City'
    special_needs 'Foo'
    occupation 'Foo'
    rg '222222'
    address 'Foo'
    geography_state_id 'GO'
    neighborhood 'Foo'
    zip_code '44444444'
    complement 'Foobar'
  end

  factory :user_with_cpf, parent: :user do
    email { generate(:email) }
    cpf { Faker::CPF.numeric }
  end

  factory :user_without_cpf, parent: :user do
    email { generate(:email) }
    cpf nil
  end
end
