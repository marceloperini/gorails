class MessageMailer < ActionMailer::Base

  default from: "GORAILS<inscricoes@gorails.com.br>"
  default to:   "GORAILS<inscricoes@gorails.com.br>"

  def new_message(message)
    @message = message

    mail subject: "Mensagem de #{message.name}"
  end

end
