class Sale < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :items

  validates :total_price, presence: true
  validates :name, presence: true, length: { minimum: 3, maximum: 70 }

  # after_save :update_total_price

  # def update_total_price
  #   self.total_price = items.sum(:selling_price)
  # end
end