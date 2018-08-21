# == Schema Information
#
# Table name: images
#
#  id         :bigint(8)        not null, primary key
#  album_id   :bigint(8)
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

require 'rails_helper'

RSpec.describe Image, type: :model do

end
