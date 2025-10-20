class Philosopher < ApplicationRecord
  # Philosophers own many quotes; removing one cascades to their quotes to avoid
  # orphan records.
  has_many :quotes, dependent: :destroy

  # Require a first name so the UI can render a meaningful display name.
  validates :first_name, presence: true
end
