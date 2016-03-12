class MessageMailer < ActionMailer::Base

  default from: "GoRails<inscricoes@gorails.com.br>"
  default to:   "GoRails<inscricoes@gorails.com.br>"

  def new_message(message)
    @message = message

    mail subject: "Mensagem de #{message.name}"
  end

end
