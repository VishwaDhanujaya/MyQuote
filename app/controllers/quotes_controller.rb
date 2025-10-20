class QuotesController < ApplicationController
  before_action :require_login
  before_action :require_active_user
  before_action :set_quote, only: %i[show edit update destroy]
  before_action :authorize_quote_access!, only: %i[show edit update destroy]
  before_action :load_categories, only: %i[new edit create update]

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
    @quote = current_user.quotes.build
    attributes = quote_params
    assign_quote_attributes(@quote, attributes)

    if @quote.errors.empty? && @quote.save
      redirect_to quotes_path, notice: "Quote created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    attributes = quote_params
    assign_quote_attributes(@quote, attributes)

    if @quote.errors.empty? && @quote.save
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

  def load_categories
    @categories = Category.order(:name)
  end

  def quote_params
    permitted = params.require(:quote).permit(
      :text,
      :publication_year,
      :user_comment,
      :is_public,
      :philosopher_first_name,
      :philosopher_last_name,
      :philosopher_biography,
      category_ids: []
    )

    permitted[:category_ids] = Array(permitted[:category_ids]).reject(&:blank?)
    permitted.to_h.symbolize_keys
  end

  def assign_quote_attributes(quote, attributes)
    attrs = attributes.dup
    category_ids = attrs.delete(:category_ids)
    philosopher_attrs = attrs.extract!(:philosopher_first_name, :philosopher_last_name, :philosopher_biography)

    quote.assign_attributes(attrs)
    quote.category_ids = category_ids if category_ids

    assign_philosopher(quote, philosopher_attrs)
  end

  def assign_philosopher(quote, philosopher_attrs)
    first_name = philosopher_attrs[:philosopher_first_name].to_s.strip
    last_name = philosopher_attrs[:philosopher_last_name].to_s.strip
    biography = philosopher_attrs[:philosopher_biography].to_s.strip

    if first_name.blank?
      quote.errors.add(:philosopher_first_name, "can't be blank")
      return false
    end

    philosopher = Philosopher
                  .where("LOWER(first_name) = ? AND LOWER(COALESCE(last_name, '')) = ?", first_name.downcase, last_name.downcase)
                  .first_or_initialize

    philosopher.first_name = first_name
    philosopher.last_name = last_name.presence
    philosopher.biography = biography.presence

    unless philosopher.save
      philosopher.errors.full_messages.each { |message| quote.errors.add(:philosopher, message) }
      return false
    end

    quote.philosopher = philosopher
    true
  end
end
