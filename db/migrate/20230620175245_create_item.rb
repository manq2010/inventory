class CreateItem < ActiveRecord::Migration[7.0]
  def self.up
    create_table :items, id: :uuid  do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
