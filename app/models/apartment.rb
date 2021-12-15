class Apartment < ApplicationRecord
  has_many :leases
  has_many :tenants, through: :leases

  validates :number, presence: true, format: { with: /\A\d+\z/, message: "Integer only. No sign allowed." }
end
