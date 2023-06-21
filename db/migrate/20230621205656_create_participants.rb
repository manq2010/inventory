class CreateParticipants < ActiveRecord::Migration[7.0]
  def self.up
    create_table :participants, id: :uuid  do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :room, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end

  def self.down
    drop_table :participants
  end
end
