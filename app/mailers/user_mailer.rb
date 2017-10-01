class UserMailer < ActionMailer::Base

  default from: "GoRails<contato@gorails.com.br>"
  default to:   "GoRails<contato@gorails.com.br>"

  def update_password(user,hashed_token)
    @user = user
    @token = hashed_token
    mail to:user.email,subject: "Atualizacao de senha de Senha"
  end

end
