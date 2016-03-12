# app/controllers/events_controller.rb
class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :register]
  #before_filter :authenticate_user!,except: [:show,:index]
  #before_filter do
   # redirect_to :new_user_session_path unless current_user && current_user.admin?
  #end
  load_and_authorize_resource :except => [:index,:show]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @event.partners.build
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Evento foi criado com sucesso!' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def register
    if @event.is_registrated?(set_user.id)
      redirect_to events_path, alert: "Este email já está registrado no evento!"
    elsif set_user.need_updated_account?
      redirect_to edit_user_registration_path, alert: "Você precisa preencher todos os dados de seu perfil antes de se inscrever em um evento!"
    else
      if @event.exceeded_limit?
        render json: { exceeded_limit: true }
      else
        @event.to_register(set_user.id)
        redirect_to events_path, notice: "Inscrito no Evento com sucesso!"
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :description, :start_at,:end_at, :local, :participants_limit, partners_attributes: [:id, :name, :link, :order, :site, :event_id, :category, :logo, :_destroy],gifts_attributes: [:id, :name, :photo, :_destroy])
  end
end
