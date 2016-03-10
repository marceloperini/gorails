class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.valid?
      MessageMailer.new_message(@message).deliver
      redirect_to contact_path, notice: "Sua Mensagem foi Enviada! Nossa equipe entrará em contato em breve."
    else
      flash[:alert] = "Um erro ocorreu e sua mensagem não pode ser enviada"
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :content)
  end

end