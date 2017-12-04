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

require 'rails_helper'

RSpec.describe Gift, type: :model do
end
