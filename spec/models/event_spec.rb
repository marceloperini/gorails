require 'rails_helper'

RSpec.describe Event, type: :model do

  let(:user) { create :user_with_cpf }
  let(:event) { create :event }

  describe "#exceeded_limit?" do
    subject(:exceeded_limit) { event.exceeded_limit? }

    context 'when limit is exceeded' do
      it 'return true' do
        create_list :registration, 10, user: user, event: event
        expect(exceeded_limit).to be_truthy
      end
    end

    context 'when limit not exceeded' do
      it 'return false' do
        create_list :registration, 9, user: user, event: event
        expect(exceeded_limit).to be_falsey
      end
    end
  end
end
