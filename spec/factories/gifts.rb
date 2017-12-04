# == Schema Information
#
# Table name: gifts
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  event_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  photo       :string
#
# Indexes
#
#  index_gifts_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#

FactoryBot.define do # frozen_string_literal: true.
  factory :gift do
    name "MyString"
    description "MyText"
    event nil
  end
end
