class CreateItems < ActiveRecord::Migration[7.0]
  def self.up
    create_table :items, id: :uuid do |t|
      t.string :title
      t.string :description
      t.decimal :price, :null => false
      t.boolean :available, null: false, default: true
      t.integer :quantity, null: false, default: 1
      t.string :category, null: false, default: ""
      t.string :sku, null: false, default: ""
      t.string :tag, null: false, default: ""
      t.integer :weight, null: false, default: ""
      t.string :size, null: false, default: ""
      t.string :color, null: false, default: ""
      t.string :slug, :null => false

      t.timestamps
    end

    add_index :items, :slug, unique: true
  end

  def self.down
    drop_table :items
  end
end
