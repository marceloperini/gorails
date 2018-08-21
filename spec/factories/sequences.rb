# frozen_string_literal: true

FactoryBot.define do
  sequence(:email) { |n| "user#{n}@test.com" }
end
