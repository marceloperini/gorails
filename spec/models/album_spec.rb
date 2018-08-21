# == Schema Information
#
# Table name: albums
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :integer
#

require 'rails_helper'

RSpec.describe Album, type: :model do

end
