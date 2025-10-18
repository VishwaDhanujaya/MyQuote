module Admin
  class UsersController < ApplicationController
    before_action :require_login
    before_action :require_active_user
    before_action :require_admin
    before_action :set_user, only: %i[edit update destroy promote demote set_status]

    def index
      @users = User.order(:first_name, :last_name)
    end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: "User updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @user == current_user
        redirect_to admin_users_path, alert: "You cannot delete your own account."
      else
        @user.destroy
        redirect_to admin_users_path, notice: "User deleted successfully."
      end
    end

    def promote
      @user.admin!
      redirect_to admin_users_path, notice: "User promoted to admin."
    end

    def demote
      @user.standard!
      redirect_to admin_users_path, notice: "User demoted to standard."
    end

    def set_status
      status = params[:status]
      if User.statuses.key?(status)
        @user.update(status: status)
        redirect_to admin_users_path, notice: "User status updated."
      else
        redirect_to admin_users_path, alert: "Invalid status."
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
  end
end
