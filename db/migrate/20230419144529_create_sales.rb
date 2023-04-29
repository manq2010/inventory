class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.string :name
      t.decimal :total_price, default: 0
      t.decimal :total_items, default: 0
      # t.datetime :date
      # t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
