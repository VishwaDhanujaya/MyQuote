class SessionsController < ApplicationController
  # Shows the login form.
  def new; end

  # Authenticates the provided credentials, prevents inactive accounts from
  # logging in, and surfaces precise feedback for failure cases.
  def create
    user = User.find_by(email: params[:email].to_s.strip.downcase)

    if user&.authenticate(params[:password])
      if user.active?
        session[:user_id] = user.id
        redirect_to root_path, notice: "Logged in successfully."
      else
        status_message = user.suspended? ? "suspended" : "banned"
        redirect_to login_path, alert: "Your account is #{status_message} and cannot be accessed. Please contact an administrator."
      end
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  # Ends the session and returns the visitor to the public homepage.
  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out successfully."
  end
end
