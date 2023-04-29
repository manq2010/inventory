class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :buying_price
      t.decimal :selling_price
      t.integer :item_quantity
      t.string :category

      t.timestamps
    end
  end
end
