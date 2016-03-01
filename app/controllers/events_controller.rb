class EventsController < ApplicationController
  before_action :set_events, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /tb_eventos
  # GET /tb_eventos.json
  def index
    @events = Event.all
  end

  # GET /tb_eventos/1
  # GET /tb_eventos/1.json
  def show
  end

  # GET /tb_eventos/new
  def new
    @event = Event.new
  end

  # GET /tb_eventos/1/edit
  def edit
  end

  # POST /tb_eventos
  # POST /tb_eventos.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Tb evento was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tb_eventos/1
  # PATCH/PUT /tb_eventos/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Tb evento was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tb_eventos/1
  # DELETE /tb_eventos/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to tb_eventos_url }
      format.json { head :no_content }
    end
  end

  def register



    respond_to do |format|
    format.html { redirect_to tb_eventos_url ,notice: "Voce Foi registrado no Evento"}
    end


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tb_evento
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :data, :description, :local, :ammount_subscripers)
    end
end
