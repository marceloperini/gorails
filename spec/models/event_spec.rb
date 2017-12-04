# == Schema Information
#
# Table name: events
#
#  id                 :integer          not null, primary key
#  name               :string
#  description        :text
#  start_at           :datetime
#  local              :text
#  participants_limit :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  end_at             :datetime
#  status             :boolean
#  event_ribbon       :string
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { create :user_with_cpf }
  let(:event) { create :event }

  describe "#exceeded_limit?" do
    subject(:exceeded_limit) { event.exceeded_limit? }

    context 'when limit not exceeded' do
      it 'return false' do
        create_list :registration, 9, user: user, event: event
        expect(exceeded_limit).to be_falsey
      end
    end
  end
end
