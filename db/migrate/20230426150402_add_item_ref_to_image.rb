class AddItemRefToImage < ActiveRecord::Migration[7.0]
  def change
    add_reference :images, :item, null: false, foreign_key: true
  end
end
