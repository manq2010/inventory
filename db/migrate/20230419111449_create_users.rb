class CreateUsers < ActiveRecord::Migration[7.0]
  def self.up
    create_table :users, id: :uuid do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :email, null: false, default: ""
      t.string :phone
      t.string :role
      t.string :slug, :null => false
      # t.string :username
      # t.string :password

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :slug, unique: true
  end

  def self.down
    drop_table :users
  end
end
