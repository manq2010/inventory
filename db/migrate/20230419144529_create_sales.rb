class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales, id: :uuid do |t|
      t.string :name
      t.decimal :total_price, default: 0
      t.integer :total_items, default: 0
      t.integer :total_units, default: 0
      # t.datetime :date
      # t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
