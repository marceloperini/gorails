require 'rails_helper'

RSpec.describe User, type: :model do

  describe "#has_valid_cpf" do
    context 'when cpf valid' do
      let(:user_valid) { create :user_with_cpf}

      it 'return true' do
        expect(user_valid.has_valid_cpf?).to be_truthy
      end
    end
  end
end
