class Sale < ApplicationRecord
  extend FriendlyId
  belongs_to :user
  has_and_belongs_to_many :items, through: :items_sales

  validates :name,  presence: true, length: { minimum: 3, maximum: 70 }
  validates :user_id,  presence: true

  # after_save :update_sale_totals
  # after_destroy :update_sale_totals

  # def update_sale_totals
  #   self.update(
  #     total_price: self.items_sales.sum('quantity * price'),
  #     total_units: self.items_sales.sum('quantity'),
  #     total_items: self.items.distinct.count(:id)
  #   )
  # end

end
