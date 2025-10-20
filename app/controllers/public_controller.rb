class PublicController < ApplicationController
  def home
    @quotes = Quote.includes(:user, :philosopher, :categories)
                   .where(is_public: true)
                   .order(created_at: :desc)
                   .limit(10)
  end

  def quotes
    @query = params[:q].to_s.strip
    scope = Quote.includes(:user, :philosopher, :categories)
                 .where(is_public: true)

    if @query.present?
      normalized_query = "%#{ActiveRecord::Base.sanitize_sql_like(@query.downcase)}%"
      scope = scope.joins(:philosopher)
                   .left_joins(:categories)
                   .where(
                     "LOWER(quotes.text) LIKE :query OR " \
                     "LOWER(quotes.user_comment) LIKE :query OR " \
                     "LOWER(philosophers.first_name) LIKE :query OR " \
                     "LOWER(philosophers.last_name) LIKE :query OR " \
                     "LOWER(categories.name) LIKE :query",
                     query: normalized_query
                   )
                   .distinct
    end

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
