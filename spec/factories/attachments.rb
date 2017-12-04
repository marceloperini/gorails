# == Schema Information
#
# Table name: attachments
#
#  id          :integer          not null, primary key
#  name        :string
#  type        :string
#  origin_type :string
#  situation   :boolean
#  origin_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  file        :string
#  file_type   :string
#
# Indexes
#
#  index_attachments_on_origin_type_and_origin_id  (origin_type,origin_id)
#

FactoryBot.define do # frozen_string_literal: true.
  factory :attachment do
  end
end
