class ItemsSale < ApplicationRecord
  belongs_to :sale
  belongs_to :item

  validates :quantity, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }
end
