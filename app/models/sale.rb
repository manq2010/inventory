class Sale < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :items

  validates :seller, :total_price, :date, :user_id, presence: true
  validates :seller, length: { minimum: 3, maximum: 70 }
end
