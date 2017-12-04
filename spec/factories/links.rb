# == Schema Information
#
# Table name: links
#
#  id               :integer          not null, primary key
#  name             :string
#  link             :string
#  link_category_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  description      :text
#
# Indexes
#
#  index_links_on_link_category_id  (link_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (link_category_id => link_categories.id)
#

FactoryBot.define do # frozen_string_literal: true.
  factory :link do
    name "MyString"
    link "MyString"
    link_category nil
  end
end
