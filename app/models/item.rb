class Item < ApplicationRecord
  has_many :images, dependent: :destroy
  has_and_belongs_to_many :sales, through: :items_sales

  validates :name, presence: true, length: { minimum: 3, message: 'Name must have 3 or more characters' }
  validates :buying_price, presence: true, numericality: { greater_than: 0, message: 'Price must be greater than 0' }
  validates :selling_price, presence: true, allow_blank: true,
                            numericality: { greater_than: 0, message: 'Price must be greater than 0' }
  validates :item_quantity, presence: true
  validates :category, presence: true
end
