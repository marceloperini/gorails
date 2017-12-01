require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe '#create' do
    let!(:user) { create(:user) }
  end
end
