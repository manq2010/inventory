class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers, id: :uuid do |t|
      t.string :customer_id
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :address1
      t.string :address2
      t.string :city
      t.string :province
      t.string :country
      t.string :zip
      t.text :phone
      t.string :province_code
      t.string :country_code
      t.string :country_name
      t.string :note
      t.string :tags
      t.string :last_order_id
      t.string :last_order_name
      t.integer :orders_count, default: 0
      t.decimal :total_spent, default: 0

      t.timestamps
    end
  end
end
