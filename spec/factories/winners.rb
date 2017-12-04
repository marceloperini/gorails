# == Schema Information
#
# Table name: winners
#
#  id         :integer          not null, primary key
#  gift_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_winners_on_gift_id  (gift_id)
#  index_winners_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (gift_id => gifts.id)
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do # frozen_string_literal: true.
  factory :winner do
    gift nil
    user nil
  end
end
