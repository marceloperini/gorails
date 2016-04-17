class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.valid?
      if verify_recaptcha(model: @message, message: "Recaptcha inválido.")
        MessageMailer.new_message(@message).deliver
        redirect_to contact_path, notice: "Sua Mensagem foi Enviada! Nossa equipe entrará em contato em breve."
      else
        render :new
      end
    else
      flash[:alert] = "Um erro ocorreu e sua mensagem não pode ser enviada"
      render :new
    end
  end

  def subscribe
    list_id = ENV['GORAILS_MAILCHIMP_LIST_ID']
    begin
      gibbon.lists(list_id).members.create(body: { email_address: params[:email][:address], status: "subscribed" })
      flash[:notice] = "Newsletter assinada com sucesso!"
    rescue Exception => e
      flash[:alert] = message_alert_newsletter(e.title)
    end
    render inline: "location.reload();"
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :content)
  end

  def message_alert_newsletter(error_title)
    return 'Email já cadastrado.' if error_title.eql?('Member Exists')
    return 'Email invalido.' if error_title.eql?('Invalid Resource')
  end

end
