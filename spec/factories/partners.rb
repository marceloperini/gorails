# == Schema Information
#
# Table name: partners
#
#  id         :integer          not null, primary key
#  name       :string
#  link       :string
#  order      :integer
#  site       :boolean
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :integer
#  logo       :string
#
# Indexes
#
#  index_partners_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#

FactoryBot.define do # frozen_string_literal: true.
  factory :partner do
  end
end
