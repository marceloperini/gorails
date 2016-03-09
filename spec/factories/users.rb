FactoryGirl.define do
  factory :user do
  	first_name 'MyFirstName'
  	last_name 'MyLastName'
  	cpf '111.111.111-11'
  	email 'user@test.com'
  	password '12345678'
    password_confirmation '12345678'
  end
end