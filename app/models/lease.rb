class Lease < ApplicationRecord
  belongs_to :apartment
  belongs_to :tenant

  validates :rent, presence: true, format: { with: /\A\d+\z/, message: "Integer only. No sign allowed." }
end
