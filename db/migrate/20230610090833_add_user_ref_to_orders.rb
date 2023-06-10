class AddUserRefToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :user, type: :uuid, null: false, foreign_key: true
  end
end