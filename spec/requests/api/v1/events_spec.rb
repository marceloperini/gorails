require 'rails_helper'

RSpec.describe 'Events management', type: :request do
  describe 'retrieves a list of events' do
    let!(:event1) { create(:event, start_at: Date.today) }
    let!(:event2) { create(:event, start_at: (Date.today + 1)) }

    before { get '/api/v1/events' }

    it 'respond with 200 status code' do
      expect(response).to be_success
    end

    it 'respond with correct json list' do
      expect(response.body).to eq([event2, event1].to_json)
    end
  end
end
