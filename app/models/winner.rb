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

class Winner < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  belongs_to :gift
  belongs_to :user
end
