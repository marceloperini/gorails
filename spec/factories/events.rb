# == Schema Information
#
# Table name: events
#
#  id                 :integer          not null, primary key
#  name               :string
#  description        :text
#  start_at           :datetime
#  local              :text
#  participants_limit :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  end_at             :datetime
#  status             :boolean
#  event_ribbon       :string
#

FactoryBot.define do # frozen_string_literal: true.
  factory :event do
  	name 'MyEvent'
  	description 'MyDescription'
  	start_at '2016-01-01'
  	end_at '2016-01-01'
  	local 'MyLocal'
  	participants_limit 10
  end
end
