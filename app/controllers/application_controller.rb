class ApplicationController < ActionController::Base
  # Ensure the UI only renders for browsers with the capabilities relied on by
  # the asset pipeline and interactive components.
  allow_browser versions: :modern

  # Make the authentication helpers available to views so navigation can adapt
  # to the current visitor’s permissions.
  helper_method :current_user, :logged_in?, :admin?

  private

  # Returns the currently logged in user, caching the lookup for the duration
  # of the request so repeated calls are inexpensive.
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Convenience predicate used by controllers and views to guard protected
  # actions or tailor copy to authenticated visitors.
  def logged_in?
    current_user.present?
  end

  # Helper that centralizes the “is admin” check used throughout controllers.
  def admin?
    logged_in? && current_user.admin?
  end

  # Redirect anonymous visitors to the login screen when they try to access an
  # authenticated workflow.
  def require_login
    return if logged_in?

    redirect_to login_path, alert: "You must be logged in to access this page."
  end

  # Guard endpoints that only administrators should reach.
  def require_admin
    return if admin?

    redirect_to root_path, alert: "You are not authorized to perform this action."
  end

  # Prevent suspended or banned accounts from continuing a session and explain
  # why they must contact staff.
  def require_active_user
    return if current_user&.active?

    reset_session
    redirect_to login_path, alert: "Your account must be active to continue."
  end
end
