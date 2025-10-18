class Quote < ApplicationRecord
  belongs_to :user
  belongs_to :philosopher
  has_many :quote_categories, dependent: :destroy
  has_many :categories, through: :quote_categories

  validates :text, presence: true
  validates :is_public, inclusion: { in: [true, false] }
  validate :must_have_category

  private

  def must_have_category
    ids = Array(category_ids).reject(&:blank?)
    errors.add(:categories, "must include at least one") if ids.empty?
  end
end
