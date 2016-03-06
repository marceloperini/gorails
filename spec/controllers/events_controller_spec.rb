require 'rails_helper'

RSpec.describe EventsController, type: :controller do

	let(:user) { create :user }
	let(:event) { create :event }

	describe '#register' do
	  context "when user is already registred" do
	  	before(:each) do
	  		create :registration, user: user, event: event
	  		post :register, { id: event.id, user_id: user.id }
	  	end

	  	it 'redirect to index of events' do
	  		expect(response).to redirect_to(events_path)
	  	end

	  	it 'received a alert' do
	  		expect(flash[:alert]).not_to be_nil
	  	end
	  end

	  context "when exceeded number of participants" do
	  	before(:each) do
	  		create_list :registration, 10, event: event
	  		post :register, { id: event.id, user_id: user.id }
	  	end

	  	it 'result of exceeded limit be true' do
	  		expect(JSON.parse(response.body)['exceeded_limit']).to be_truthy
	  	end
	  end

	  context "when not exceeded number of participants and first register of user" do
	  	before(:each) do
	  		post :register, { id: event.id, user_id: user.id }
	  	end

	  	it 'redirect to index of events' do
	  		expect(response).to redirect_to(events_path)
	  	end

	  	it 'received a notice' do
	  		expect(flash[:notice]).not_to be_nil
	  	end
	  end
	end
end
