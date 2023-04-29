class ItemsSale < ApplicationRecord
    belongs_to :sale
    belongs_to :item

    validates :quantity, numericality: { greater_than: 0 }
end



# class SalesItem < ApplicationRecord
#   belongs_to :sale
#   belongs_to :item



#   after_create :decrement_item_quantity

#   private

#   def decrement_item_quantity
#     item.decrement!(:total_quantity, quantity)
#   end
# end
