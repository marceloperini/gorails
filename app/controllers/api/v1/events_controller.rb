class Api::V1::EventsController < ApplicationController
  before_action :set_event, only: %i(show)

  respond_to :json

  # GET /api/v1/events.json
  def index
    @events = Event.all.order('start_at DESC')
    render json: @events, status: 200
  end

  # GET /api/v1/event/:id.json
  def show
    render json: @event, status: 200
  end

  private

  def set_event
    @event = Event.find params[:id]
  end
end
