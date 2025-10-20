class User < ApplicationRecord
  # Handles password hashing/verification and exposes `authenticate`.
  has_secure_password

  # Roles control access to administrative features; status tracks account
  # health so suspended users can be locked out without deleting data.
  enum :role, { standard: 0, admin: 1 }
  enum :status, { active: 0, suspended: 1, banned: 2 }

  # Users author many quotes; removing a user clears their contributions to
  # maintain referential integrity.
  has_many :quotes, dependent: :destroy

  # Core profile details and email uniqueness ensure we can contact the user and
  # log them in reliably.
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  # Keep emails normalized so uniqueness comparisons are case-insensitive and
  # whitespace-safe.
  before_validation :normalize_email

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end
