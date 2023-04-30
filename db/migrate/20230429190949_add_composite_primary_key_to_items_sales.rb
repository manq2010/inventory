class AddCompositePrimaryKeyToItemsSales < ActiveRecord::Migration[7.0]
  def change
    add_column :items_sales, :id, :primary_key
  end
end
