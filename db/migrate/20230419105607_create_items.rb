class CreateItems < ActiveRecord::Migration[7.0]
  def self.up
    create_table :items, id: :uuid do |t|
      t.string :name
      t.decimal :buying_price
      t.decimal :selling_price
      t.integer :item_quantity
      t.string :category
      t.string :slug, :null => false

      t.timestamps
    end

    add_index :items, :slug, unique: true
  end

  def self.down
    drop_table :items
  end
end
