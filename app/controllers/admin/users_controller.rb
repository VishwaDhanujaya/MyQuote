module Admin
  class UsersController < ApplicationController
    # Every action in the admin namespace requires an authenticated, active
    # administrator account. The user lookup is reused across the management
    # operations in this controller.
    before_action :require_login
    before_action :require_active_user
    before_action :require_admin
    before_action :set_user, only: %i[edit update destroy promote demote set_status]

    # Lists the managed users, excluding the current admin to avoid presenting
    # destructive options that immediately fail.
    def index
      @users = User.where.not(id: current_user.id).order(:first_name, :last_name)
    end

    # Presents the account editing form for administrators.
    def edit; end

    # Saves attribute changes and reports validation issues inline.
    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: "User updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # Deletes a user account, guarding against self-deletion so the admin
    # remains able to manage the system.
    def destroy
      if @user == current_user
        redirect_to admin_users_path, alert: "You cannot delete your own account."
      else
        @user.destroy
        redirect_to admin_users_path, notice: "User deleted successfully."
      end
    end

    # Upgrades another account to the admin role.
    def promote
      return redirect_to admin_users_path, alert: "You cannot change your own role." if @user == current_user

      @user.admin!
      redirect_to admin_users_path, notice: "User promoted to admin."
    end

    # Downgrades an admin back to the standard role.
    def demote
      return redirect_to admin_users_path, alert: "You cannot change your own role." if @user == current_user

      @user.standard!
      redirect_to admin_users_path, notice: "User demoted to standard."
    end

    # Applies the requested status transition (active/suspended/banned) after
    # verifying it is supported and not targeting the acting admin.
    def set_status
      status = params[:status]
      return redirect_to admin_users_path, alert: "You cannot change your own status." if @user == current_user

      if User.statuses.key?(status)
        @user.update(status: status)
        redirect_to admin_users_path, notice: "User status updated."
      else
        redirect_to admin_users_path, alert: "Invalid status."
      end
    end

    private

    # Fetches the account targeted by the administrative action.
    def set_user
      @user = User.find(params[:id])
    end

    # Limits admin edits to safe, profile-level attributes.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
  end
end
