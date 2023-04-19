class CreateJoinTableItemSale < ActiveRecord::Migration[7.0]
  def change
    create_join_table :items, :sales do |t|
      t.index [:item_id, :sale_id]
      t.index [:sale_id, :item_id]

      t.timestamps
    end
  end
end
