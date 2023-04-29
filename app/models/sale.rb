class Sale < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :items, through: :items_sales

  validates :total_price, :total_units, presence: true
  validates :name, presence: true, length: { minimum: 3, maximum: 70 }
end
