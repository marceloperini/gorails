class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: %i(index)
  load_and_authorize_resource only: %i(index)
  def index
    @users = User.all
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