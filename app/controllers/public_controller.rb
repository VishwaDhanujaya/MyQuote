class PublicController < ApplicationController
  def home
    @quotes = Quote.includes(:user, :philosopher, :categories)
                   .where(is_public: true)
                   .order(created_at: :desc)
                   .limit(10)
  end

  def quotes
    @query = params[:q].to_s.strip
    scope = Quote.includes(:user, :philosopher).where(is_public: true)
    scope = scope.where("LOWER(text) LIKE ?", "%#{@query.downcase}%") if @query.present?
    @quotes = scope.order(created_at: :desc)
    @categories = Category.order(:name)
  end

  def by_category
    @category = Category.find(params[:id])
    @quotes = @category.quotes.includes(:user, :philosopher)
                         .where(is_public: true)
                         .order(created_at: :desc)
  end
end
