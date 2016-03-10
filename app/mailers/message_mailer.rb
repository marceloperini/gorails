class MessageMailer < ActionMailer::Base

  default from: "GORAILS<contato@gorails.com.br>"
  default to:   "GORAILS<contato@gorails.com.br>"

  def new_message(message)
    @message = message

    mail subject: "Mensagem de #{message.name}"
  end

end