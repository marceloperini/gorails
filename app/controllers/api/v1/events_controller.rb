class Api::V1::EventsController < ApplicationController
  respond_to :json

  # GET /events.json
  def index
    @events = Event.all.order('start_at DESC')
    render json: @events, status: 200
  end
end
