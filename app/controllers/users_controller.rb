class UsersController < ApplicationController
  # Registration is open to everyone, but profile edits require the session to
  # belong to the owner of the account and for the account to be active.
  before_action :require_login, only: %i[edit update]
  before_action :require_active_user, only: %i[edit update]
  before_action :set_user, only: %i[edit update]
  before_action :authorize_user!, only: %i[edit update]

  # Presents the sign-up form for new visitors.
  def new
    @user = User.new
  end

  # Creates a fresh account, defaulting to the standard role and active status,
  # and logs the user in on success.
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

  # Renders the profile edit form.
  def edit; end

  # Applies profile updates when the data validates successfully.
  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # Finds the user associated with the form submission.
  def set_user
    @user = User.find(params[:id])
  end

  # Prevents one user from modifying another user’s account.
  def authorize_user!
    return if current_user == @user

    redirect_to root_path, alert: "You are not authorized to modify this account."
  end

  # Allows only the fields collected on the profile forms.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
