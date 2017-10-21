FactoryBot.define do # frozen_string_literal: true.
  sequence(:email) { |n| "user#{n}@test.com" }
end
