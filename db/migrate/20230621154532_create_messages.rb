class CreateMessages < ActiveRecord::Migration[7.0]
  def self.up
    create_table :messages, id: :uuid  do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :room, type: :uuid, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end