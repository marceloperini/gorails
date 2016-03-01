class TbEventosController < ApplicationController
  before_action :set_tb_evento, only: [:show, :edit, :update, :destroy]

  # GET /tb_eventos
  # GET /tb_eventos.json
  def index
    @tb_eventos = TbEvento.all
  end

  # GET /tb_eventos/1
  # GET /tb_eventos/1.json
  def show
  end

  # GET /tb_eventos/new
  def new
    @tb_evento = TbEvento.new
  end

  # GET /tb_eventos/1/edit
  def edit
  end

  # POST /tb_eventos
  # POST /tb_eventos.json
  def create
    @tb_evento = TbEvento.new(tb_evento_params)

    respond_to do |format|
      if @tb_evento.save
        format.html { redirect_to @tb_evento, notice: 'Tb evento was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tb_evento }
      else
        format.html { render action: 'new' }
        format.json { render json: @tb_evento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tb_eventos/1
  # PATCH/PUT /tb_eventos/1.json
  def update
    respond_to do |format|
      if @tb_evento.update(tb_evento_params)
        format.html { redirect_to @tb_evento, notice: 'Tb evento was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tb_evento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tb_eventos/1
  # DELETE /tb_eventos/1.json
  def destroy
    @tb_evento.destroy
    respond_to do |format|
      format.html { redirect_to tb_eventos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tb_evento
      @tb_evento = TbEvento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tb_evento_params
      params.require(:tb_evento).permit(:nome, :data, :descricao, :local, :limite_participantes)
    end
end
