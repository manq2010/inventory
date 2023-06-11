class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :pic
      t.decimal :total_price
      t.string :status
      t.string :slug, :null => false
      # t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :orders, :slug, unique: true
  end
end
