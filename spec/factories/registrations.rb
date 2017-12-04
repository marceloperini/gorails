# == Schema Information
#
# Table name: registrations
#
#  id             :integer          not null, primary key
#  event_id       :integer
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  presence       :boolean          default(FALSE)
#  certified_code :string
#
# Indexes
#
#  index_registrations_on_certified_code  (certified_code) UNIQUE
#

FactoryBot.define do # frozen_string_literal: true.
  factory :registration do
    event
    association :user, factory: :user_with_cpf
  end
end
