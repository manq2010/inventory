class CreateRooms < ActiveRecord::Migration[7.0]
  def self.up
    create_table :rooms, id: :uuid do |t|
      t.string :name
      t.boolean :is_private, default: false

      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
