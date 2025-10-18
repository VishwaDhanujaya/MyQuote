class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?, :admin?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def admin?
    logged_in? && current_user.admin?
  end

  def require_login
    return if logged_in?

    redirect_to login_path, alert: "You must be logged in to access this page."
  end

  def require_admin
    return if admin?

    redirect_to root_path, alert: "You are not authorized to perform this action."
  end

  def require_active_user
    return if current_user&.active?

    reset_session
    redirect_to login_path, alert: "Your account must be active to continue."
  end
end
