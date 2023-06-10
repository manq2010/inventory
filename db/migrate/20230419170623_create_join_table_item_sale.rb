class CreateJoinTableItemSale < ActiveRecord::Migration[7.0]
  def change
    create_join_table :items, :sales, id: :uuid do |t|
      t.index [:item_id, :sale_id]
      t.index [:sale_id, :item_id]
      t.integer :quantity, default: 1
      t.decimal :price, default: 0

      t.timestamps
    end
  end
end
