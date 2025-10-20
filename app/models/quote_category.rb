class QuoteCategory < ApplicationRecord
  # Join model linking quotes to their categories.
  belongs_to :quote
  belongs_to :category

  # Prevent duplicate category assignments for the same quote.
  validates :quote_id, uniqueness: { scope: :category_id }
end
