class Philosopher < ApplicationRecord
  has_many :quotes, dependent: :destroy

  validates :first_name, presence: true
end
