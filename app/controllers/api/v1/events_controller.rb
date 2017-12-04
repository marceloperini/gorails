class Api::V1::EventsController < Api::BaseController
  before_action :set_event, only: %i(show)

  # GET /api/v1/events.json
  def index
    @events = Event.all.order('start_at DESC')
    render success_message(@events)
  end

  # GET /api/v1/event/:id.json
  def show
    render success_message(@event)
  end

  private

  def set_event
    @event = Event.find params[:id]
  end

  def success_message(message)
    { json: message, status: 200 }
  end
end
