# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  album_id   :integer
#  asset      :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_images_on_album_id  (album_id)
#
# Foreign Keys
#
#  fk_rails_...  (album_id => albums.id)
#

FactoryBot.define do # frozen_string_literal: true.
  factory :image do
    album nil
    asset "MyString"
    title "MyString"
  end
end
