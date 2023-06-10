class AddCompositePrimaryKeyToItemsSales < ActiveRecord::Migration[7.0]
  def change
    add_column :items_sales, :id, :uuid, default: "gen_random_uuid()", null: false
  end
end
