class Quote < ApplicationRecord
  # Quotes originate from a user and must point to a philosopher. Categories are
  # managed via the join table.
  belongs_to :user
  belongs_to :philosopher
  has_many :quote_categories, dependent: :destroy
  has_many :categories, through: :quote_categories

  # Require meaningful quote content and explicit publication state so the UI
  # knows whether to expose it publicly.
  validates :text, presence: true
  validates :is_public, inclusion: { in: [true, false] }
  validate :must_have_category

  private

  # Enforces that every quote is tagged with at least one category, ensuring it
  # appears in filtered searches.
  def must_have_category
    ids = Array(category_ids).reject(&:blank?)
    errors.add(:categories, "must include at least one") if ids.empty?
  end
end
