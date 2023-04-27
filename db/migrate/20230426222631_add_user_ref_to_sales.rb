class AddUserRefToSales < ActiveRecord::Migration[7.0]
  def change
    add_reference :sales, :user, null: false, foreign_key: true
  end
end
