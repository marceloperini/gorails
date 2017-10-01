class MessageMailer < ActionMailer::Base

  default from: "GoRails<contato@gorails.com.br>"
  default to:   "GoRails<contato@gorails.com.br>"

  def new_message(message)
    @message = message

    mail to:'contato@gorails.com.br',subject: "Mensagem de #{message.name}"
  end

end
