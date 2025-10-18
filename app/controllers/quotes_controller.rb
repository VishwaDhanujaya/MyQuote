class QuotesController < ApplicationController
  before_action :require_login
  before_action :require_active_user
  before_action :set_quote, only: %i[show edit update destroy]
  before_action :authorize_quote_access!, only: %i[show edit update destroy]
  before_action :load_form_collections, only: %i[new edit create update]

  def index
    @quotes = if admin?
                Quote.includes(:user, :philosopher, :categories).order(created_at: :desc)
              else
                current_user.quotes.includes(:philosopher, :categories).order(created_at: :desc)
              end
  end

  def show; end

  def new
    @quote = current_user.quotes.build
  end

  def create
    @quote = current_user.quotes.build(quote_params)

    if @quote.save
      redirect_to quotes_path, notice: "Quote created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @quote.update(quote_params)
      redirect_to quotes_path, notice: "Quote updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quote.destroy
    redirect_to quotes_path, notice: "Quote deleted successfully."
  end

  private

  def set_quote
    @quote = Quote.find(params[:id])
  end

  def authorize_quote_access!
    return if admin?
    return if @quote.user == current_user

    redirect_to quotes_path, alert: "You are not authorized to access this quote."
  end

  def load_form_collections
    @philosophers = Philosopher.order(:first_name, :last_name)
    @categories = Category.order(:name)
  end

  def quote_params
    permitted = params.require(:quote).permit(:text, :publication_year, :user_comment, :is_public, :philosopher_id, category_ids: [])
    permitted[:category_ids] = permitted[:category_ids].reject(&:blank?) if permitted[:category_ids].is_a?(Array)
    permitted
  end
end
