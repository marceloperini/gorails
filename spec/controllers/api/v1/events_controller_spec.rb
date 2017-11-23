require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  describe '#index' do
    let!(:event1) { create(:event, start_at: Date.today) }
    let!(:event2) { create(:event, start_at: (Date.today + 1)) }

    it 'populates an array with events' do
      get :index, format: :json
      expect(assigns(:events)).to eq([event2, event1])
    end

    it 'respond with 200 code' do
      get :index, format: :json
      expect(response.status).to eq(200)
    end

    it 'respond with JSON' do
      get :index, format: :json
      expect(response.body).to eq([event2, event1].to_json)
    end
  end
end
