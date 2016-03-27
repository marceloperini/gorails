FactoryGirl.define do
  factory :user do
    nickname 'MyNickName'
    first_name 'MyFirstName'
    last_name 'MyLastName'
    password '12345678'
    password_confirmation '12345678'
  end

  factory :user_with_cpf, parent: :user do
    email 'user@test.com'
    cpf '54256315454'
  end

  factory :user_without_cpf, parent: :user do
    email 'user2@test.com'
    cpf nil
  end

end
