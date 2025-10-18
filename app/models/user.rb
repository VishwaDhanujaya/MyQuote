class User < ApplicationRecord
  has_secure_password

  enum :role, { standard: 0, admin: 1 }
  enum :status, { active: 0, suspended: 1, banned: 2 }

  has_many :quotes, dependent: :destroy

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  before_validation :normalize_email

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end
