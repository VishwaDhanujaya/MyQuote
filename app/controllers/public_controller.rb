class PublicController < ApplicationController
  def home
    @quotes = Quote.includes(:user, :philosopher, :categories)
                   .where(is_public: true)
                   .order(created_at: :desc)
                   .limit(10)
  end

  def quotes
    @query = params[:q].to_s.strip
    @selected_category_ids = Array(params[:categories]).reject(&:blank?).map(&:to_i)

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
    else
      scope = scope.joins(:philosopher)
    end

    if @selected_category_ids.any?
      matching_ids = Quote.joins(:categories)
                          .where(categories: { id: @selected_category_ids })
                          .group(:id)
                          .having("COUNT(DISTINCT categories.id) = ?", @selected_category_ids.size)
      scope = scope.where(id: matching_ids)
    end

    @quotes = scope.order(created_at: :desc)
    @categories = Category.order(:name)
    @selected_categories = Category.where(id: @selected_category_ids).order(:name)
  end

  def by_category
    @category = Category.find(params[:id])
    @quotes = @category.quotes.includes(:user, :philosopher)
                         .where(is_public: true)
                         .order(created_at: :desc)
  end
end
