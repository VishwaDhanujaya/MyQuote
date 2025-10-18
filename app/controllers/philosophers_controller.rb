class PhilosophersController < ApplicationController
  before_action :require_login
  before_action :require_active_user
  before_action :require_admin
  before_action :set_philosopher, only: %i[show edit update destroy]

  def index
    @philosophers = Philosopher.order(:first_name, :last_name)
  end

  def show; end

  def new
    @philosopher = Philosopher.new
  end

  def create
    @philosopher = Philosopher.new(philosopher_params)

    if @philosopher.save
      redirect_to philosophers_path, notice: "Philosopher created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @philosopher.update(philosopher_params)
      redirect_to philosophers_path, notice: "Philosopher updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @philosopher.destroy
    redirect_to philosophers_path, notice: "Philosopher removed successfully."
  end

  private

  def set_philosopher
    @philosopher = Philosopher.find(params[:id])
  end

  def philosopher_params
    params.require(:philosopher).permit(:first_name, :last_name, :birth_year, :death_year, :biography)
  end
end
