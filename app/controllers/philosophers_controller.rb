class PhilosophersController < ApplicationController
  # Administrators maintain the philosopher catalogue used for quote
  # attribution. All actions require an active admin session.
  before_action :require_login
  before_action :require_active_user
  before_action :require_admin
  before_action :set_philosopher, only: %i[show edit update destroy]

  # Lists all philosophers alphabetically by their names.
  def index
    @philosophers = Philosopher.order(:first_name, :last_name)
  end

  # Displays the selected philosopher and their associated information.
  def show; end

  # Presents an empty form for recording a new philosopher.
  def new
    @philosopher = Philosopher.new
  end

  # Persists the philosopher record, redisplaying the form when validations fail.
  def create
    @philosopher = Philosopher.new(philosopher_params)

    if @philosopher.save
      redirect_to philosophers_path, notice: "Philosopher created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Populates the edit form with the selected philosopher’s details.
  def edit; end

  # Applies updates to the philosopher entry.
  def update
    if @philosopher.update(philosopher_params)
      redirect_to philosophers_path, notice: "Philosopher updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Removes the philosopher, cascading deletes to their quotes.
  def destroy
    @philosopher.destroy
    redirect_to philosophers_path, notice: "Philosopher removed successfully."
  end

  private

  # Finds the philosopher record targeted by the action.
  def set_philosopher
    @philosopher = Philosopher.find(params[:id])
  end

  # Only allow trusted parameters representing philosopher attributes.
  def philosopher_params
    params.require(:philosopher).permit(:first_name, :last_name, :birth_year, :death_year, :biography)
  end
end
