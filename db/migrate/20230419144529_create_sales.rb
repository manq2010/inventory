class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.string :seller
      t.decimal :total_price
      t.datetime :date

      t.timestamps
    end
  end
end
