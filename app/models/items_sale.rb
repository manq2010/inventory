class ItemsSale < ApplicationRecord
  belongs_to :sale
  belongs_to :item

  validates :quantity, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }

  # before_save :update_sale_totals
  # before_create :add_item_sale_price
  # before_destroy :subtract_item_sale_price

  # private
  
  # def update_sale_totals
  #   sale.update(
  #     total_price: sale.items_sales.sum('quantity * price'),
  #     total_units: sale.items_sales.sum(:quantity),
  #     total_items: sale.items.distinct.count(:item_id)
  #   )
  # end

  # after_save :update_sale_totals
  # after_destroy :update_sale_totals

  # private

  # def update_sale_totals
  #   sale.update_sale_totals
  # end
end
