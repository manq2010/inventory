class CreateJoinTableItemOrder < ActiveRecord::Migration[7.0]
  def change
    create_join_table :items, :orders do |t|
      t.index [:item_id, :order_id]
      t.index [:order_id, :item_id]

      t.timestamps
    end
  end
end
