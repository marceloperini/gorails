# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :integer
#

FactoryBot.define do # frozen_string_literal: true.
  factory :album do
    title "MyString"
  end
end
