class ApplicationController < ActionController::Base
  def redirect_to(*args)
    flash.keep
    super
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

	def sanitize(params)
    ActionController::Base.helpers.sanitize(params)
  end

  include PublicActivity::StoreController
  hide_action :current_user

end


