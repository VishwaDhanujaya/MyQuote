class Category < ApplicationRecord
  # Categories label quotes and cascade deletes through the join table so stale
  # associations are cleaned up automatically.
  has_many :quote_categories, dependent: :destroy
  has_many :quotes, through: :quote_categories

  # Each category needs a unique name so it can be referenced reliably in forms
  # and filters.
  validates :name, presence: true, uniqueness: true
end
