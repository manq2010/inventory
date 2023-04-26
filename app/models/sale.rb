class Sale < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :items

  validates :name, :total_price, presence: true
  validates :name, length: { minimum: 3, maximum: 70 }
end
