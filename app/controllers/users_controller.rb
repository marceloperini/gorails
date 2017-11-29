class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: %i(index)
  load_and_authorize_resource only: %i(index)

  def index
    @users = UserFinder.search(first_name: params[:first_name], email: params[:email], provider: params[:provider], page: params[:page])
  end

  def show
    @user
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: @user, owner_type: "User")
  end

  def edit
    @user.build_profile if @user.profile.nil?
  end

  def update
    if @user.update(user_params)
      redirect_to user_profile_path(@user)
    else
      render 'edit'
    end
  end

  def certified
    if params[:certified_code].present? and params[:certified_code] != ''
      @register_certified = Registration.where('certified_code = ? and presence is true', params[:certified_code]).first
      if @register_certified
        @certified_event = Event.find(@register_certified.event_id)
        @certified_user = User.find(@register_certified.user_id)
        render 'show_certified'
      else
        flash[:alert] = "Por favor digite um código valido de um diploma emitido pela GoRails"
        render 'certified'
      end
    end
  end

  def uf_id_extended
    uf_id = Geography::State.where(" initials ilike ? ", params[:uf_initals]).first.id

    respond_to do |format|
      format.json {render json: uf_id}
    end
  end

  def name_alter
    unless params[params.keys.first].blank?
      user_inline = User.find(params.keys.first.split('_').last.to_i)
      user_inline.first_name = params[params.keys.first].split(' ').first
      user_inline.last_name = params[params.keys.first].split(' ')[1..-1].join(' ')
      user_inline.save
    end
    head 204, content_type: "text/html"
  end


  private

  def set_user
    @user = User.find(params[:id])

  end

  def user_params
    params.require(:user).permit(profile_attributes: [:id, :name, :cid, :birthday, :sex, :tel, :address, :tagline, :introduction, :avatar])
  end

  def authenticate_owner!
    redirect_to root_path unless user_signed_in? && current_user.to_param == params[:id]
  end

end