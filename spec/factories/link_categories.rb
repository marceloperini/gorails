# == Schema Information
#
# Table name: link_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do # frozen_string_literal: true.
  factory :link_category do
    name "MyString"
  end
end
