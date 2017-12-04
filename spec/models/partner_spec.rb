# == Schema Information
#
# Table name: partners
#
#  id         :integer          not null, primary key
#  name       :string
#  link       :string
#  order      :integer
#  site       :boolean
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :integer
#  logo       :string
#
# Indexes
#
#  index_partners_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#

require 'rails_helper'

RSpec.describe Partner, type: :model do
  let(:partner) { Partner.new } 

  context "a context" do
    it "description" do
        
    end    
  end
end
