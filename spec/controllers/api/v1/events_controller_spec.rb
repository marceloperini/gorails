require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  describe '#index' do
    let!(:event1) { create(:event, start_at: Date.today) }
    let!(:event2) { create(:event, start_at: (Date.today + 1)) }

    before { get :index, format: :json }

    it 'populates an array with events' do
      expect(assigns(:events)).to eq([event2, event1])
    end

    it 'respond with 200 code' do
      expect(response.status).to eq(200)
    end

    it 'respond with correct content' do
      expect(response.body).to eq([event2, event1].to_json)
    end
  end

  describe '#show' do
    let!(:event) { create(:event) }

    before { get :show, params: { id: event.id }, format: :json }

    it 'assign a event variable' do
      expect(assigns(:event)).to eq(event)
    end

    it 'respond with 200 code' do
      expect(response.status).to eq(200)
    end

    it 'respond with JSON' do
      expect(response.body).to eq()
    end
  end
end
