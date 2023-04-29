class Item < ApplicationRecord
  has_many :images, dependent: :destroy
  has_and_belongs_to_many :sales

  validates :name, presence: true, length: { minimum: 3, message: 'Name must have 3 or more characters' }
  validates :buying_price, presence: true, numericality: { greater_than: 0, message: 'Price must be greater than 0' }
  validates :selling_price, presence: true, allow_blank: true,
                            numericality: { greater_than: 0, message: 'Price must be greater than 0' }
  validates :quantity, presence: true
  validates :category, presence: true
end
