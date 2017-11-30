FactoryBot.define do # frozen_string_literal: true.
  factory :registration do
    event
    association :user, factory: :user_with_cpf
  end
end
