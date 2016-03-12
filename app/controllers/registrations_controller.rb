# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  private
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :cpf, :provider, :uid)
  end
  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :nickname,:cpf,:email, :password, :password_confirmation, :current_password)
  end
end
