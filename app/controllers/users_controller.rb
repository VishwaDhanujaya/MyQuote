class UsersController < ApplicationController
  before_action :require_login, only: %i[edit update]
  before_action :require_active_user, only: %i[edit update]
  before_action :set_user, only: %i[edit update]
  before_action :authorize_user!, only: %i[edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = :standard
    @user.status = :active

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user!
    return if current_user == @user

    redirect_to root_path, alert: "You are not authorized to modify this account."
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
