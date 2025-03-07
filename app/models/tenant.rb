class Tenant < ApplicationRecord
    has_many :leases
    has_many :apartment, through: :leases

    validates :name, presence: true
    validates :age, presence: true, numericality: { greater_than_or_equal_to: 18,  only_integer: true }
end
